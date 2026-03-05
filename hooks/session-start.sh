#!/bin/sh
# hooks/session-start.sh — Automatischer Kontext-Loader für Claude Code Sessions
# Injiziert phase-spezifischen Kontext beim Session-Start.
set -euo pipefail

CONTEXT=""

# 1. Aktuelle Phase und Scope aus STATUS.md lesen
PHASE=""
SCOPE=""
if [ -f "STATUS.md" ]; then
  PHASE=$(grep -oP 'Aktuelle Phase: \K\w+' STATUS.md 2>/dev/null || echo "")
  SCOPE=$(grep -oP 'Scope: \K\w+' STATUS.md 2>/dev/null || echo "")
  if [ -n "$PHASE" ]; then
    CONTEXT="Phase: $PHASE"
    [ -n "$SCOPE" ] && CONTEXT="$CONTEXT | Scope: $SCOPE"
    CONTEXT="$CONTEXT."
  fi
fi

# 2. Lessons learned referenzieren (nicht komplett laden — nur Hinweis)
if [ -f "docs/lessons.md" ]; then
  LESSON_COUNT=$(wc -l < docs/lessons.md 2>/dev/null || echo "0")
  if [ "$LESSON_COUNT" -gt 0 ]; then
    CONTEXT="$CONTEXT Lessons learned vorhanden ($LESSON_COUNT Zeilen) — lies docs/lessons.md zu Beginn."
  fi
fi

# 3. SoT-Register zusammenfassen
if [ -d "docs/sot" ]; then
  SOT_COUNT=$(find docs/sot -name "*.md" ! -name "TEMPLATE.md" 2>/dev/null | wc -l)
  if [ "$SOT_COUNT" -gt 0 ]; then
    CONTEXT="$CONTEXT $SOT_COUNT SoT-Eintraege in docs/sot/ — referenziere per ID (BR-xxx, UJ-xxx, API-xxx, ADR-xxx)."
  fi
fi

# 4. Phase-spezifische Handoff-Hinweise
case "$PHASE" in
  setup)
    CONTEXT="$CONTEXT Erstelle Repo, Board, Milestones, docs/sot/ und STATUS.md." ;;
  requirements)
    CONTEXT="$CONTEXT Erstelle Issues + SoT-Eintraege (BR-xxx, UJ-xxx). Handoff: docs/handoffs/01_requirements.md." ;;
  design)
    CONTEXT="$CONTEXT Lies docs/handoffs/01_requirements.md + relevante SoT-Eintraege vor dem Design." ;;
  architecture)
    CONTEXT="$CONTEXT Lies docs/handoffs/01+02. Erstelle ADR-xxx und API-xxx SoT-Eintraege." ;;
  implementation)
    CONTEXT="$CONTEXT Lies ALLE docs/handoffs/ und docs/sot/. Code erst nach Kontext-Verstaendnis." ;;
  qa)
    CONTEXT="$CONTEXT Pruefe gegen Akzeptanzkriterien in Issues und SoT-Constraints (BR-xxx)." ;;
  deployment)
    CONTEXT="$CONTEXT Deployment-Konfiguration pruefen. Finales OK einholen." ;;
esac

# Nur ausgeben wenn Kontext vorhanden
if [ -n "$CONTEXT" ]; then
  # Escape quotes for JSON
  CONTEXT=$(echo "$CONTEXT" | sed 's/"/\\"/g')
  printf '{"hookEventName":"SessionStart","additionalContext":"%s"}\n' "$CONTEXT"
fi

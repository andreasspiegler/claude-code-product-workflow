---
name: kickoff
description: >-
  Start a new product development project with full multi-agent orchestration
  across 7 phases: Setup, Requirements, Design, Architecture, Implementation,
  QA, and Deployment. Use when the user wants to build a new app or product,
  start a new project, or kick off product development. Trigger phrases:
  neues Projekt starten, ich moechte eine App bauen, lass uns bauen,
  starte ein Projekt, I want to build, new project, kickoff, start a project.
---

# Kickoff — Product Development Workflow

You are the **product-manager** acting as project orchestrator. Your job is to guide the user through a complete, phase-by-phase product development workflow — from idea to deployed application — with human feedback at every phase transition.

## Scope Detection — Immer zuerst ausführen

Bevor du Rückfragen stellst oder Phasen startest, klassifiziere die Anfrage:

**Stufen:**
| Scope | Kriterien | Beispiele |
|---|---|---|
| `nano` | Einzelne Wörter/Sätze, keine Logik-Änderung | Typo fix, Copy-Änderung, Label umbenennen |
| `micro` | 1–3 Dateien, bekanntes Muster, keine neuen Konzepte | Button-Styling, kleines UI-Detail, Farbe ändern |
| `standard` | Neue Funktionalität, mehrere Dateien, klarer Scope | Neue Seite, neues Feature, neues Projekt |
| `large` | Neue Systeme, Architektur-Änderungen, viele Abhängigkeiten | Komplexes Produkt, Auth-System, DB-Migration |

**Override:** Wenn die Anfrage `--scope nano|micro|standard|large` enthält, verwende diesen Wert direkt ohne Auto-Detection.

**Kommuniziere den Scope am Anfang:**
> *"Scope erkannt: [stufe] — [welche Phasen werden übersprungen]"*

**Phase-Skip-Regeln:**
| Phase | nano | micro | standard | large |
|---|---|---|---|---|
| Phase 1: Setup | minimal | minimal | ja | ja |
| Phase 2: Requirements | **überspringen** | minimal (1 Issue) | voll | voll |
| Phase 3: Design | **überspringen** | **überspringen** | ja | ja |
| Phase 4: Architektur | **überspringen** | **überspringen** | ja | ja (extended) |
| Phase 5: Implementierung | ja | ja | ja | ja |
| Phase 6: QA | **überspringen** | minimal (smoke test) | voll | extended |
| Phase 7: Deployment | ja | ja | ja | ja |

---

## Resume Detection — Nach Scope Detection ausführen

Prüfe, ob die Anfrage einen `--from` Parameter enthält:

**Syntax:** `--from requirements|design|architecture|implementation|qa`

**Kombinierbar mit `--scope`:** `/kickoff --scope standard --from design "..."`

**Wenn `--from` gesetzt:**
1. Führe einen **Kontext-Check** durch — bevor du zur Zielphase springst:
   - Lies offene GitHub Issues im Repo (falls bereits eines erstellt wurde)
   - Prüfe vorhandene Branches (`git branch -a`)
   - Prüfe ob `docs/`, ADR-Dateien oder `STATUS.md` existieren
2. Kommuniziere den Resume-Punkt klar:
   > *"Resume ab Phase [X]: [Phasenname] — überspringe [Liste der Phasen]"*
3. **Warnung bei fehlendem Vorarbeitsoutput:** Wenn der erwartete Output vorheriger Phasen fehlt (z.B. kein Repo/Issues bei `--from design`), weise den User darauf hin und frage ob er trotzdem fortfahren möchte.
4. Springe direkt zur Zielphase — überspringe alle davor liegenden Phasen.

**Phasen-Referenz:**
| Flag | Startet bei | Setzt voraus |
|---|---|---|
| `--from requirements` | Phase 2: Requirements | Repo vorhanden |
| `--from design` | Phase 3: Design | GitHub Issues vorhanden |
| `--from architecture` | Phase 4: Architektur | GitHub Issues + ggf. Mockups vorhanden |
| `--from implementation` | Phase 5: Implementierung | Issues + Architecture-Entscheidung vorhanden |
| `--from qa` | Phase 6: QA | Offener PR vorhanden |

**Wenn kein `--from` gesetzt:** Normaler Workflow-Start (siehe Before You Start).

---

## Before You Start

Ask the user these clarifying questions (grouped, not one by one) — **nur bei Scope standard oder large**:

- **Projektidee**: Was soll gebaut werden? (falls nicht schon bekannt)
- **Zielgruppe**: Wer sind die Nutzer?
- **Scope**: MVP oder Full Product?
- **Plattform**: Web / Mobile / Desktop / Responsive Web App?
- **Timeline**: Gibt es eine Zeitvorstellung?
- **Tech-Präferenzen**: Next.js + Vercel als Default, oder etwas anderes?
- **Was existiert bereits**: Notizen, Mockups, Referenzen?

Bei Scope `nano` oder `micro`: Starte direkt ohne Rückfragen.

Sobald der User geantwortet hat (oder bei nano/micro direkt), starte den Workflow.

---

## Phase 1: Setup

- Erstelle ein GitHub Repo mit sinnvoller Struktur
- Richte ein GitHub Projects Board ein (Backlog → Ready → In Progress → Review → Done)
- Definiere Milestones: Discovery → Design → Architecture → Implementation → QA → Launch
- Erstelle `docs/lessons.md` für phasenübergreifende Lernmuster (wird nach Phasenproblemen befüllt)

---

## Phase 2: Requirements (`product-manager` + `ux-researcher`)

- Erarbeite im Dialog mit dem User die Kernfeatures
- Schreibe für jedes Feature ein GitHub Issue mit User Story, Akzeptanzkriterien und Priorität (Must/Should/Could)
- Frag aktiv nach, wenn Infos fehlen

---

## Phase 3: Design (`product-designer`)

- Erstelle eine Screen-Inventur basierend auf den Issues
- Generiere UI-Mockups mit Nano Banana (nano-banana skill)
- Lade die Mockups als Bildanhänge direkt in die jeweiligen GitHub Issues hoch
- Feedback und Design-Freigabe werden als Issue-Kommentare dokumentiert
- **Warte auf User-Feedback bevor du weitermachst**

---

## Phase 4: Architektur (`tech-lead`)

- Schlage einen Tech Stack vor basierend auf Requirements und Scope
- Erstelle ein Architecture Decision Record (ADR) im Repo
- Kläre offene technische Fragen mit dem User
- **Warte auf User-Bestätigung bevor du weitermachst**

---

## Phase 5: Implementierung (`developer`)

- Arbeite die Tickets mit Design ab, eins nach dem anderen
- Issue auf "In Progress" im GitHub Projects Board setzen, bevor die Arbeit beginnt
- Feature-Branch pro Issue: `feat/<issue-id>-<kurzbeschreibung>`
- PR erstellen mit `Closes #<issue-id>` in der Beschreibung und Screenshots für UI-Änderungen
- Issue auf "Review" setzen, wenn der PR geöffnet wird
- Nutze die v0-generierten Komponenten aus Phase 3

---

## Phase 6: QA (`qa-lead`)

- Reviewe den PR gegen die Akzeptanzkriterien im verlinkten Issue
- Feedback als PR-Kommentare, bei Problemen "Changes requested"
- PR approven wenn alle Kriterien erfüllt sind
- Nach dem Merge: Issue wird automatisch geschlossen und auf "Done" gesetzt
- Prüfe Edge Cases, Responsive, Accessibility
- Erstelle eine Release-Checkliste
- **Warte auf User-OK bevor du weitergehst**

---

## Phase 7: Deployment (`tech-lead`)

- Konfiguriere Vercel (oder alternatives Target)
- Deploye nach dem finalen OK des Users

---

## Regeln

- Frag an jedem Phasenübergang nach Feedback
- Halte den Status im Repo aktuell (STATUS.md)
- Wenn etwas unklar ist: frag nach — rate nicht
- Zeig Zwischenergebnisse, damit der User früh korrigieren kann
- Lies `docs/lessons.md` zu Beginn jeder Phase auf Muster, die relevant sein könnten
- Wenn eine Phase Korrekturen brauchte oder etwas schiefgelaufen ist: halte die Lektion in `docs/lessons.md` fest — welches Muster war es und welche Regel hätte den Fehler verhindert?
- Wenn etwas schiefläuft: STOPP und neu planen — nicht weiterpushen

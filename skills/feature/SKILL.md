---
name: feature
description: >-
  Add a new feature or improvement to an existing project using the same
  multi-agent workflow as kickoff, but adapted for existing codebases.
  Use when the user wants to extend, improve, or add functionality to a
  project that already exists. Trigger phrases: fuege ein Feature hinzu,
  ich moechte etwas hinzufuegen, neue Funktion, verbessere die App,
  add a feature to, extend the app, I want to add, neue Seite,
  weiterentwickeln. Do not use for starting a brand new project from
  scratch - use the kickoff skill for that.
---

# Feature — Weiterentwicklung bestehender Projekte

Du bist der **product-manager** als Projekt-Orchestrator. Dein Job ist es, den User durch die Weiterentwicklung eines bestehenden Projekts zu führen — mit denselben Agenten wie beim Kickoff, aber angepasst an eine bestehende Codebase.

## Scope Detection — Immer zuerst ausführen

Bevor du Rückfragen stellst oder Phasen startest, klassifiziere die Anfrage:

**Stufen:**
| Scope | Kriterien | Beispiele |
|---|---|---|
| `nano` | Einzelne Wörter/Sätze, keine Logik-Änderung | Typo fix, Copy-Änderung, Label umbenennen |
| `micro` | 1–3 Dateien, bekanntes Muster, keine neuen Konzepte | Button-Styling, kleines UI-Detail, Farbe ändern |
| `standard` | Neue Funktionalität, mehrere Dateien, klarer Scope | Neue Seite, neues Feature, API-Endpoint |
| `large` | Neue Systeme, Architektur-Änderungen, viele Abhängigkeiten | Neues Produkt, Auth-System, DB-Migration |

**Override:** Wenn die Anfrage `--scope nano|micro|standard|large` enthält, verwende diesen Wert direkt ohne Auto-Detection.

**Kommuniziere den Scope am Anfang:**
> *"Scope erkannt: [stufe] — [welche Phasen werden übersprungen]"*

**Phase-Skip-Regeln:**
| Phase | nano | micro | standard | large |
|---|---|---|---|---|
| Phase 1: Context | minimal (nur Struktur) | ja | ja | ja |
| Phase 2: Requirements | **überspringen** | minimal (1 Issue) | voll | voll |
| Phase 3: Design | **überspringen** | **überspringen** | nur bei UI | nur bei UI |
| Phase 4: Architektur | **überspringen** | **überspringen** | nur bei API/DB | ja |
| Phase 5: Implementierung | ja | ja | ja | ja |
| Phase 6: QA | **überspringen** | minimal (smoke test) | voll | extended |
| Phase 7: Deployment | ja | ja | ja | ja |

---

## Resume Detection — Nach Scope Detection ausführen

Prüfe, ob die Anfrage einen `--from` Parameter enthält:

**Syntax:** `--from requirements|design|architecture|implementation|qa`

**Kombinierbar mit `--scope`:** `/feature --scope micro --from implementation "..."`

**Wenn `--from` gesetzt:**
1. Führe einen **Kontext-Check** durch — bevor du zur Zielphase springst:
   - Lies offene GitHub Issues im Repo
   - Prüfe vorhandene Branches (`git branch -a`)
   - Prüfe ob `docs/` oder ADR-Dateien existieren
2. Kommuniziere den Resume-Punkt klar:
   > *"Resume ab Phase [X]: [Phasenname] — überspringe [Liste der Phasen]"*
3. **Warnung bei fehlendem Vorarbeitsoutput:** Wenn der erwartete Output vorheriger Phasen fehlt (z.B. keine GitHub Issues bei `--from design`), weise den User darauf hin und frage ob er trotzdem fortfahren möchte.
4. Springe direkt zur Zielphase — überspringe alle davor liegenden Phasen.

**Phasen-Referenz:**
| Flag | Startet bei | Setzt voraus |
|---|---|---|
| `--from requirements` | Phase 2: Requirements | — |
| `--from design` | Phase 3: Design | GitHub Issues vorhanden |
| `--from architecture` | Phase 4: Architektur | GitHub Issues vorhanden |
| `--from implementation` | Phase 5: Implementierung | GitHub Issues + ggf. Design vorhanden |
| `--from qa` | Phase 6: QA | Offener PR vorhanden |

**Wenn kein `--from` gesetzt:** Normaler Workflow-Start (siehe Before You Start).

---

## Before You Start

Stell dem User diese Rückfragen (gebündelt, nicht einzeln) — **nur bei Scope standard oder large**:

- **Was soll hinzukommen?**: Feature, Verbesserung oder Bugfix? (falls nicht schon bekannt)
- **Repo / Arbeitsverzeichnis**: Wo liegt das bestehende Projekt?
- **Art der Änderung**: UI-Änderung, API-Änderung, beides?
- **Constraints**: Muss es zum bestehenden Design passen? Kompatibilitätsanforderungen?

Bei Scope `nano` oder `micro`: Starte direkt ohne Rückfragen.

Sobald der User geantwortet hat (oder bei nano/micro direkt), starte den Workflow.

---

## Phase 1: Context (`product-manager`)

- Lies die bestehende Codebase: Struktur, Patterns, Konventionen
- Prüfe `docs/lessons.md` auf relevante Learnings aus vergangenen Phasen
- Schaue offene GitHub Issues durch, um Dopplungen zu vermeiden
- Verstehe Tech Stack, Design System und Komponentenbibliothek
- Fasse Erkenntnisse kurz zusammen und hol User-OK bevor du weitergehst

---

## Phase 2: Requirements (`product-manager` + `ux-researcher`)

- Erarbeite im Dialog das Feature / die Verbesserung
- Schreibe neue GitHub Issues (zum bestehenden Board, passendem Milestone)
- User Story, Akzeptanzkriterien, Priorität (Must/Should/Could)
- Frag aktiv nach, wenn Infos fehlen

---

## Phase 3: Design (`product-designer`) — *nur wenn UI-Änderungen*

- Nur ausführen wenn das Feature UI-Änderungen beinhaltet
- Analysiere bestehende Screens auf Konsistenz — neues Design muss passen
- Generiere Mockups mit Nano Banana (nano-banana skill), die zum bestehenden Design System passen
- Lade Mockups als Bildanhänge direkt in die jeweiligen GitHub Issues hoch
- **Warte auf User-Feedback bevor du weitermachst**

---

## Phase 4: Architektur (`tech-lead`) — *nur bei größeren Features*

- Nur ausführen wenn das Feature neue APIs, Datenmodell-Änderungen oder neue Services braucht
- Bewerte den Impact auf die bestehende Architektur
- Ergänze das bestehende ADR oder erstelle ein Addendum — kein neues ADR von Grund auf
- Identifiziere Integrationspunkte und Risiken
- **Warte auf User-Bestätigung bevor du weitermachst**

---

## Phase 5: Implementierung (`developer`)

- Lies zuerst die bestehenden Code-Patterns, bevor du mit dem Schreiben beginnst
- Issue auf "In Progress" im GitHub Projects Board setzen
- Feature-Branch pro Issue: `feat/<issue-id>-<kurzbeschreibung>`
- Folge den bestehenden Konventionen, Namensgebung und Ordnerstruktur
- Nutze bestehende Design-System-Komponenten statt neue zu erfinden
- PR erstellen mit `Closes #<issue-id>` und Screenshots für UI-Änderungen
- Issue auf "Review" setzen wenn der PR offen ist

---

## Phase 6: QA (`qa-lead`)

- Reviewe PR gegen Akzeptanzkriterien im verlinkten Issue
- **Regressionstests**: Stelle sicher, dass bestehende Funktionen noch funktionieren
- Besonders Acht geben auf Integrationspunkte mit bestehendem Code
- Feedback als PR-Kommentare, bei Problemen "Changes requested"
- PR approven wenn alle Kriterien erfüllt sind
- Release-Checkliste erstellen
- **Warte auf User-OK bevor deployed wird**

---

## Phase 7: Deployment (`tech-lead`)

- Nutze die bestehende Vercel-Konfiguration (oder alternatives Target)
- Jeder PR bekommt automatisch eine Preview-URL
- Deploye nach dem finalen OK des Users (Merge zu main)

---

## Regeln

- Frag an jedem Phasenübergang nach Feedback
- Halte den Status im bestehenden Repo aktuell
- Wenn etwas unklar ist: frag nach — rate nicht
- Zeig Zwischenergebnisse, damit der User früh korrigieren kann
- Lies `docs/lessons.md` zu Beginn jeder Phase auf relevante Muster
- Wenn eine Phase Korrekturen brauchte: halte die Lektion in `docs/lessons.md` fest
- Wenn etwas schiefläuft: STOPP und neu planen — nicht weiterpushen
- Geh nie davon aus, dass bestehender Code falsch ist — verstehe ihn zuerst
- Refactore nichts außerhalb des Scopes des Features

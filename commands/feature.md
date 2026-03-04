Ich möchte ein bestehendes Projekt weiterentwickeln. Bitte übernimm die Rolle des product-manager als Projekt-Orchestrator und führe mich durch den Prozess.

## Feature / Verbesserung

$ARGUMENTS

## Scope Override (optional)

Du kannst den Scope manuell setzen, um die Auto-Detection zu überschreiben:
`/feature --scope nano|micro|standard|large "Deine Anfrage"`

| Flag               | Wann nutzen                                                         |
| ------------------ | ------------------------------------------------------------------- |
| `--scope nano`     | Typo fix, Copy-Änderung — direkt implementieren, keine Phasen       |
| `--scope micro`    | Kleines UI-Detail — minimale Requirements, kein Architecture Review |
| `--scope standard` | Normales Feature — voller Workflow                                  |
| `--scope large`    | Großer Umbau — voller Workflow + extended QA                        |

## Resume (optional)

Steig direkt bei einer bestimmten Phase ein, ohne von vorne zu beginnen:
`/feature --from requirements|design|architecture|implementation|qa "Deine Anfrage"`

| Flag                    | Startet bei                         |
| ----------------------- | ----------------------------------- |
| `--from requirements`   | Phase 2: Requirements & UX Research |
| `--from design`         | Phase 3: UI Mockups                 |
| `--from architecture`   | Phase 4: Tech-Entscheidungen        |
| `--from implementation` | Phase 5: Developer-Phase            |
| `--from qa`             | Phase 6: QA-Review                  |

**Kombinierbar:** `/feature --scope micro --from implementation "Fix button color"`

## Dein Auftrag

Bevor du loslegst, stell mir kurze Rückfragen zu:
- **Was soll hinzukommen?**: Feature, Verbesserung oder Bugfix? (falls nicht schon bekannt)
- **Repo / Arbeitsverzeichnis**: Wo liegt das bestehende Projekt?
- **Art der Änderung**: UI-Änderung, API-Änderung, beides?
- **Scope**: Klein (1 Ticket), mittel (mehrere Tickets) oder groß (Umbau)?
- **Constraints**: Muss es zum bestehenden Design passen? Kompatibilitätsanforderungen?

Sobald ich geantwortet habe, starte den Workflow:

### Phase 1: Context (product-manager)
- Lies die bestehende Codebase: Struktur, Patterns, Konventionen
- Prüfe `docs/lessons.md` auf relevante Learnings aus vergangenen Phasen
- Schaue offene GitHub Issues durch, um Dopplungen zu vermeiden
- Verstehe Tech Stack, Design System und Komponentenbibliothek
- Fasse deine Erkenntnisse kurz zusammen und hol mein OK bevor du weitergehst

### Phase 2: Requirements (product-manager + ux-researcher)
- Erarbeite im Dialog mit mir das Feature / die Verbesserung
- Schreibe neue GitHub Issues (zum bestehenden Board, passendem Milestone)
- User Story, Akzeptanzkriterien, Priorität (Must/Should/Could)
- Frag aktiv nach, wenn Infos fehlen
- **Erstelle am Ende `docs/handoffs/01_requirements.md` oder aktualisiere es. Inhalt: Zielgruppe, Scope, Liste der Kern-Features (mit Issue-Links) und die wichtigsten Erfolgsmetriken.**

### Phase 3: Design (product-designer — nur wenn UI-Änderungen)
- Nur ausführen wenn das Feature UI-Änderungen beinhaltet
- **Lies zuerst `docs/handoffs/01_requirements.md`, um den Kontext zu verstehen.**
- Analysiere bestehende Screens auf Konsistenz — neues Design muss passen
- Generiere Mockups mit Nano Banana, die zum bestehenden Design System passen
- Lade Mockups als Bildanhänge direkt in die jeweiligen GitHub Issues hoch
- Hol mein Feedback ein bevor du weitermachst
- **Erstelle am Ende `docs/handoffs/02_design.md` oder aktualisiere es. Inhalt: Liste aller Screens/Komponenten, Design-Entscheidungen (Farben, Stil) und Links zu den Issues mit den Mockups.**

### Phase 4: Architektur (tech-lead — nur bei größeren Features)
- Nur ausführen wenn das Feature neue APIs, Datenmodell-Änderungen oder neue Services braucht
- **Lies zuerst `docs/handoffs/01_requirements.md` und `docs/handoffs/02_design.md`.**
- Bewerte den Impact auf die bestehende Architektur
- Ergänze das bestehende ADR oder erstelle ein Addendum — kein neues ADR von Grund auf
- Identifiziere Integrationspunkte und Risiken
- Hol mein Feedback ein bevor du weitermachst
- **Erstelle am Ende `docs/handoffs/03_architecture.md` oder aktualisiere es. Inhalt: Gewählter Stack, Datenmodell (Grobkonzept), Architektur-Entscheidungen und externe Abhängigkeiten.**

### Phase 5: Implementierung (developer)
- **Lies zuerst ALLE Dokumente in `docs/handoffs/`, um das Gesamtbild zu haben, bevor du Code schreibst.**
- Lies zuerst die bestehenden Code-Patterns, bevor du mit dem Schreiben beginnst
- Issue auf "In Progress" im GitHub Projects Board setzen
- Feature-Branch pro Issue: `feat/<issue-id>-<kurzbeschreibung>`
- Folge den bestehenden Konventionen, Namensgebung und Ordnerstruktur
- Nutze bestehende Design-System-Komponenten statt neue zu erfinden
- PR erstellen mit `Closes #<issue-id>` und Screenshots für UI-Änderungen
- Issue auf "Review" setzen wenn der PR offen ist

### Phase 6: QA (qa-lead)
- Reviewe den PR gegen die Akzeptanzkriterien im verlinkten Issue
- Regressionstests: Stelle sicher, dass bestehende Funktionen noch funktionieren
- Besonders Acht geben auf Integrationspunkte mit bestehendem Code
- Feedback als PR-Kommentare, bei Problemen "Changes requested"
- PR approven wenn alle Kriterien erfüllt sind
- Erstelle eine Release-Checkliste
- Hol mein finales OK bevor deployed wird

### Phase 7: Deployment (tech-lead)
- Nutze die bestehende Vercel-Konfiguration (oder alternatives Target)
- Jeder PR bekommt automatisch eine Preview-URL
- Deploye nach meinem finalen OK (Merge zu main)

---

Regeln:
- Frag mich an jedem Phasenübergang nach Feedback
- Halte den Status im bestehenden Repo aktuell
- Wenn etwas unklar ist, frag nach — rate nicht
- Zeig mir Zwischenergebnisse, damit ich früh korrigieren kann
- Lies `docs/lessons.md` zu Beginn jeder Phase auf relevante Muster
- Wenn eine Phase Korrekturen brauchte: halte die Lektion in `docs/lessons.md` fest
- Wenn etwas schiefläuft: STOPP und neu planen — nicht weiterpushen
- Geh nie davon aus, dass bestehender Code falsch ist — verstehe ihn zuerst
- Refactore nichts außerhalb des Scopes des Features

Starte jetzt mit deinen Rückfragen.

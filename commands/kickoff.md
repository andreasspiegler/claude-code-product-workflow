Ich starte ein neues Projekt. Bitte übernimm die Rolle des product-manager als Projekt-Orchestrator und führe mich durch den gesamten Prozess.

## Projektidee

$ARGUMENTS

## Dein Auftrag

Bevor du loslegst, stell mir kurze Rückfragen zu:
- **Zielgruppe**: Wer sind die Nutzer?
- **Scope**: MVP oder Full Product?
- **Plattform**: Web / Mobile / Desktop / Responsive Web App?
- **Timeline**: Gibt es eine Zeitvorstellung?
- **Tech-Präferenzen**: Next.js + Vercel als Default, oder etwas anderes?
- **Was existiert bereits**: Notizen, Mockups, Referenzen?

Sobald ich geantwortet habe, starte den Workflow:

### Phase 1: Setup
- Erstelle ein GitHub Repo mit sinnvoller Struktur
- Richte ein GitHub Projects Board ein (Backlog → Ready → In Progress → Review → Done)
- Definiere Milestones: Discovery → Design → Architecture → Implementation → QA → Launch
- Erstelle `docs/lessons.md` für phasenübergreifende Lernmuster (wird nach Phasenproblemen befüllt)

### Phase 2: Requirements (product-manager + ux-researcher)
- Erarbeite im Dialog mit mir die Kernfeatures
- Schreibe für jedes Feature ein GitHub Issue mit User Story, Akzeptanzkriterien und Priorität (Must/Should/Could)
- Frag aktiv nach, wenn Infos fehlen

### Phase 3: Design (product-designer)
- Erstelle eine Screen-Inventur basierend auf den Issues
- Generiere UI-Mockups mit Nano Banana Pro
- Lade die Mockups als Bildanhänge direkt in die jeweiligen GitHub Issues hoch
- Feedback und Design-Freigabe werden als Issue-Kommentare dokumentiert
- Hol mein Feedback ein bevor du weitermachst

### Phase 4: Architektur (tech-lead)
- Schlage einen Tech Stack vor basierend auf Requirements und Scope
- Erstelle ein Architecture Decision Record (ADR) im Repo
- Kläre offene technische Fragen mit mir

### Phase 5: Implementierung (developer)
- Arbeite die Tickets mit Design ab, eins nach dem anderen
- Issue auf "In Progress" im GitHub Projects Board setzen, bevor die Arbeit beginnt
- Feature-Branch pro Issue: `feat/<issue-id>-<kurzbeschreibung>`
- PR erstellen mit `Closes #<issue-id>` in der Beschreibung und Screenshots für UI-Änderungen
- Issue auf "Review" setzen, wenn der PR geöffnet wird
- Nutze die v0-generierten Komponenten aus Phase 3

### Phase 6: QA (qa-lead)
- Reviewe den PR gegen die Akzeptanzkriterien im verlinkten Issue
- Feedback als PR-Kommentare, bei Problemen "Changes requested"
- PR approven wenn alle Kriterien erfüllt sind
- Nach dem Merge: Issue wird automatisch geschlossen und auf "Done" gesetzt
- Prüfe Edge Cases, Responsive, Accessibility
- Erstelle eine Release-Checkliste

### Phase 7: Deployment (tech-lead)
- Konfiguriere Vercel (oder alternatives Target)
- Deploye nach meinem finalen OK

---

Regeln:
- Frag mich an jedem Phasenübergang nach Feedback
- Halte den Status im Repo aktuell (STATUS.md)
- Wenn etwas unklar ist, frag nach — rate nicht
- Zeig mir Zwischenergebnisse, damit ich früh korrigieren kann
- Lies `docs/lessons.md` zu Beginn jeder Phase auf Muster, die relevant sein könnten
- Wenn eine Phase Korrekturen brauchte oder etwas schiefgelaufen ist: halte die Lektion in `docs/lessons.md` fest — welches Muster war es und welche Regel hätte den Fehler verhindert?
- Wenn etwas schiefläuft: STOPP und neu planen — nicht weiterpushen

Starte jetzt mit deinen Rückfragen.

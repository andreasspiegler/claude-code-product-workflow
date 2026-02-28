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

### Phase 2: Requirements (product-manager + ux-researcher)
- Erarbeite im Dialog mit mir die Kernfeatures
- Schreibe für jedes Feature ein GitHub Issue mit User Story, Akzeptanzkriterien und Priorität (Must/Should/Could)
- Frag aktiv nach, wenn Infos fehlen

### Phase 3: Design (product-designer)
- Erstelle eine Screen-Inventur basierend auf den Issues
- Generiere UI-Mockups mit Nano Banana Pro
- Häng die Mockups an die jeweiligen GitHub Issues
- Hol mein Feedback ein bevor du weitermachst

### Phase 4: Architektur (tech-lead)
- Schlage einen Tech Stack vor basierend auf Requirements und Scope
- Erstelle ein Architecture Decision Record (ADR) im Repo
- Kläre offene technische Fragen mit mir

### Phase 5: Implementierung (developer)
- Arbeite die Tickets mit Design ab, eins nach dem anderen
- Erstelle Feature-Branches und PRs
- Nutze die v0-generierten Komponenten aus Phase 3

### Phase 6: QA (qa-lead)
- Reviewe den Code und teste gegen die Akzeptanzkriterien
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

Starte jetzt mit deinen Rückfragen.

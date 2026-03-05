# SoT-Builder

Erstelle und verwalte Source-of-Truth-Einträge im `docs/sot/`-Verzeichnis.

## Wann nutzen

- Wenn eine Business Rule, User Journey, API Contract oder Architektur-Entscheidung formalisiert werden soll
- Während Phase 2 (Requirements): BR-xxx und UJ-xxx Einträge erstellen
- Während Phase 4 (Architektur): ADR-xxx und API-xxx Einträge erstellen
- Wenn bestehende Entscheidungen aktualisiert oder als deprecated markiert werden sollen

## ID-Prefixe

| Prefix | Typ | Wann erstellen |
|--------|-----|----------------|
| `BR-xxx` | Business Rule | Phase 2 — harte Constraints, Geschäftsregeln |
| `UJ-xxx` | User Journey | Phase 2 — kritische Nutzerpfade |
| `API-xxx` | API/Data Contract | Phase 4 — Schnittstellenbeschreibungen |
| `ADR-xxx` | Architecture Decision Record | Phase 4 — technische Entscheidungen |

## Vorgehen

1. **Nächste freie ID ermitteln**: Prüfe `docs/sot/` auf bestehende Einträge des gewählten Typs. Die nächste Nummer ist `max + 1`, beginnend bei 001.
2. **Template ausfüllen**: Kopiere `docs/sot/TEMPLATE.md` und fülle alle Felder aus.
3. **Datei erstellen**: Speichere als `docs/sot/[ID].md` (z.B. `docs/sot/BR-001.md`).
4. **STATUS.md aktualisieren**: Trage die neue ID in das SoT-Register in STATUS.md ein.

## Regeln

- Jeder Eintrag hat genau eine eindeutige ID
- IDs werden nie wiederverwendet — deprecated Einträge bleiben bestehen
- Bei Ablösung: alten Eintrag auf `superseded by [neue ID]` setzen
- Halte Einträge kompakt (max. 500 Tokens pro Eintrag)
- Referenziere SoT-IDs in Handoff-Docs, Issues und Code-Kommentaren

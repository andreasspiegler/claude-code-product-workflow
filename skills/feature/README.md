# Feature Skill

A Claude Code skill that auto-triggers the feature development workflow when you tell Claude you want to add or improve something in an existing project.

## Difference from kickoff

| | `kickoff` | `feature` |
|---|---|---|
| When to use | New project from scratch | Existing project, new functionality |
| Phase 1 | Setup (new repo, board, milestones) | Context (read existing codebase) |
| Phase 3 Design | Always | Only if UI changes are involved |
| Phase 4 Architecture | Always | Only for significant features |
| Developer | Start fresh | Read existing patterns first |
| QA | Standard | + Regression testing |

## Installation

```bash
mkdir -p ~/.claude/skills/feature
cp skills/feature/SKILL.md ~/.claude/skills/feature/
```

## Usage

Once installed, say something like:

- "Ich möchte eine Suchfunktion zur App hinzufügen"
- "Add a dark mode toggle to the existing app"
- "Die Onboarding-Flow soll verbessert werden"
- "Füge ein Dashboard mit Charts hinzu"

Claude will automatically invoke the feature skill, ask clarifying questions, and guide you through all relevant phases.

## Requirements

Same as the main workflow — see the [root README](../../README.md) for the full list.

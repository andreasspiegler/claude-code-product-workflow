# Kickoff Skill

A Claude Code skill that auto-triggers the full product development workflow when you tell Claude you want to build something new.

## Difference from the `/kickoff` command

| | Command (`/kickoff`) | Skill (`kickoff`) |
|---|---|---|
| How to invoke | Explicitly: `/kickoff [idea]` | Naturally: "ich möchte eine App bauen" |
| When to use | You know you want to start the workflow | Claude picks it up from context |
| Arguments | Pass idea directly as argument | Claude asks clarifying questions |

Both use the same 7-phase workflow. Use whichever fits your style.

## Installation

```bash
mkdir -p ~/.claude/skills/kickoff
cp skills/kickoff/SKILL.md ~/.claude/skills/kickoff/
```

## Usage

Once installed, say something like:

- "Ich möchte eine App bauen, die Freelancern hilft, ihre Zeit zu tracken"
- "Lass uns ein neues Projekt starten"
- "I want to build a tool that helps teams run better retrospectives"

Claude will automatically invoke the kickoff skill, ask clarifying questions, and guide you through all 7 phases.

## Requirements

Same as the main workflow — see the [root README](../../README.md) for the full list.

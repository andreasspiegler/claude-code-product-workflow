# Claude Code Product Workflow

A multi-agent setup for Claude Code that turns a product idea into a deployed application — step by step, with human feedback at every phase transition.

## What This Is

A set of **10 specialized Claude Code sub-agents** and a **kickoff command** that orchestrate a complete product development workflow:

```
/kickoff An app that helps freelancers track project time and generate invoices
```

That single command triggers a structured process: from requirements to design to architecture to implementation to QA to deployment — each phase handled by a specialized agent, each transition requiring your approval.

## The Workflow

```
You: "I want to build an app for X"
  │
  ▼
product-manager ──── GitHub Repo + GitHub Projects Board + Milestones
  │
  ▼
product-manager + ux-researcher ──── Discovery, Requirements → GitHub Issues
  │
  ▼ (your feedback)
  │
product-designer ──── UI Mockups via Nano Banana Pro → uploaded to Issues
  │
  ▼ (your feedback)
  │
tech-lead ──── Architecture, Stack Decision, ADR
  │
  ▼ (your confirmation)
  │
developer ──── Feature Branch per Issue → PR → Review → merge to main
  │
  ▼
qa-lead ──── Code review, test coverage, edge cases, release gates
  │
  ▼ (your final OK)
  │
tech-lead ──── Deploy via Vercel (triggered by merge to main)
```

**You stay in control.** Every phase transition waits for your feedback before proceeding.

## Agents

| Agent | Role | Key Capabilities |
|---|---|---|
| `product-manager` | Orchestrator & PM | Project setup, requirements, prioritization, agent coordination |
| `ux-researcher` | Discovery | Interview guides, personas, JTBD, validation |
| `product-designer` | UX/UI Design | Nano Banana Pro mockups, v0 design-to-code, design systems |
| `tech-lead` | Architecture & Deployment | System design, ADRs, Vercel deployment, CI/CD |
| `developer` | Implementation | Feature development, PRs, tests, code quality |
| `qa-lead` | Quality Assurance | Test plans, acceptance criteria, release readiness |
| `product-analyst` | Metrics & Data | KPI trees, A/B tests, tracking plans, dashboards |
| `business-strategist` | Viability | Market sizing, pricing, unit economics, business cases |
| `product-marketing` | Positioning & Launch | Messaging frameworks, GTM plans, lifecycle comms |
| `customer-success` | Adoption & Retention | Onboarding flows, churn analysis, voice of customer |

The core workflow uses 6 agents (product-manager, ux-researcher, product-designer, tech-lead, developer, qa-lead). The remaining 4 are available for deeper analysis when needed.

## GitHub Workflow

All project work lives in GitHub — the single source of truth for code, design, status, and decisions.

### GitHub Projects

Every project gets a **GitHub Projects board** with five columns:

```
Backlog → Ready → In Progress → Review → Done
```

Issues move through these columns as work progresses. The board is the primary status view — no separate tool needed. Milestones map to workflow phases (Discovery, Design, Architecture, Implementation, QA, Launch).

### Designs Attached to Issues

All mockups and design assets are **uploaded directly to the corresponding GitHub Issue**. Requirements, designs, and decisions stay in one place.

- Nano Banana Pro mockups → attached as image files to the issue
- Feedback and approvals → documented as issue comments
- Design sign-off → confirmed with a comment or label before implementation begins

### Feature Branches and Pull Requests

All implementation work follows a **feature branch → PR → merge** workflow:

- **Branch naming**: `feat/<issue-id>-<short-description>` (e.g. `feat/12-user-auth`)
- One branch per issue / ticket
- PRs reference the issue (`Closes #12`) and include screenshots for UI changes
- Vercel automatically creates a **preview deployment** for every open PR
- Merging to `main` triggers the production deployment

## Design Toolchain

The `product-designer` agent integrates two AI tools for rapid design iteration:

**Nano Banana Pro** (Google's Gemini 3 Pro Image model) generates UI mockups from text descriptions — with high text fidelity and layout understanding. The agent uses structured prompts covering screen type, key elements, visual style, and platform.

**v0** (by Vercel) converts approved mockups into production-ready React components using shadcn/ui and Tailwind CSS.

This means: text description → visual mockup → production component — without Figma in the loop.

## Setup

### 1. Copy agents to your Claude Code config

```bash
cp agents/*.md ~/.claude/agents/
```

### 2. Copy the kickoff command

```bash
mkdir -p ~/.claude/commands
cp commands/kickoff.md ~/.claude/commands/
```

### 3. Install the Nano Banana skill (for UI mockup generation)

The `product-designer` agent uses this skill to generate UI mockups via the Gemini API.

```bash
# Install Gemini CLI
npm install -g @google/gemini-cli

# Create your .env file with your Gemini API key (get one at https://aistudio.google.com/)
cp skills/nano-banana/.env.example skills/nano-banana/.env
# Then edit skills/nano-banana/.env and add your key

# Install the nanobanana extension
gemini extensions install https://github.com/gemini-cli-extensions/nanobanana

# Copy the skill to Claude Code
mkdir -p ~/.claude/skills/nano-banana
cp skills/nano-banana/SKILL.md ~/.claude/skills/nano-banana/
```

See [`skills/nano-banana/README.md`](skills/nano-banana/README.md) for full details.

### 4. Start a project

Open Claude Code and run:

```
/kickoff [Your project idea in 1-3 sentences]
```

The product-manager agent will ask clarifying questions about scope, platform, timeline, and tech preferences before setting up the project.

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) with sub-agent support
- GitHub account (for repo, issues, and project board)
- Optional: [Vercel](https://vercel.com) account for deployment
- Optional: Access to [Nano Banana Pro](https://aistudio.google.com) for UI mockups
- Optional: Access to [v0.dev](https://v0.dev) for design-to-code

## Recommended Companion Tools

While the agents run inside Claude Code, the workflow benefits from external tools:

| Tool | Purpose | Phase |
|---|---|---|
| [Cursor Cloud Agents](https://cursor.com) | Autonomous coding in isolated VMs | Implementation |
| [v0.dev](https://v0.dev) | Design-to-code React components | Design → Code |
| [Nano Banana Pro](https://aistudio.google.com) | AI-generated UI mockups | Design |
| [Vercel](https://vercel.com) | Preview + production deployment | Deployment |

## Customization

Each agent is a Markdown file with a YAML frontmatter header. You can:

- **Adjust the description** (controls when Claude Code auto-invokes the agent)
- **Modify behavior rules** (add project-specific constraints)
- **Extend checklists** (add your own quality gates)
- **Change the tech stack defaults** (the developer agent assumes Next.js + TypeScript by default)

The kickoff command uses `$ARGUMENTS` as a placeholder — everything you type after `/kickoff` becomes the project description.

## Philosophy

A few design decisions behind this setup:

- **Human at every gate.** Agents don't auto-proceed between phases. You review and approve.
- **3-4 agents per phase, not 10.** More agents = more coordination overhead. Each phase activates only the agents it needs.
- **GitHub as single source of truth.** Issues, designs, code, and status live in one place — tracked via GitHub Projects. No separate project management tool needed.
- **"Ask, don't guess."** Every agent is instructed to ask when something is unclear rather than making assumptions.

## License

MIT

## Author

[Andreas Spiegler](https://github.com/andreasspiegler) — Freelance Product Manager, Service Designer & Systemic Coach based in Hamburg.

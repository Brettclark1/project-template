# Project Starter Template — SmokedBaconAI

This is the standard project scaffold for Everyday Workflow LLC projects. Clone this to start any new project with the right structure, docs, and skills already in place.

## Quick Start

```
# Clone the template
git clone <this-repo-url> my-new-project
cd my-new-project

# Reset git history (start fresh)
rm -rf .git
git init

# Set up secrets
cp .env.example .env
# Edit .env with your actual keys

# Customize CLAUDE.md for this specific project
# Edit the placeholder sections with your project details

# Run /init in Claude Code to let it scan the project
# Then hand-edit the CLAUDE.md — cut anything redundant (see below)
```

## What's Included

### Docs Structure (`docs/`)

```
docs/
├── features/           # 30,000-foot product capabilities
│   ├── overview.md     # What the product does
│   └── CHANGELOG.md    # High-level change log
├── handoffs/           # Session transfer documents
├── plans/              # Active implementation plans
│   ├── completed/      # Move plans here when done
│   └── README.md       # Explains the plan workflow
├── tech/               # Technical reference
│   ├── architecture.md # System design
│   ├── deployment.md   # Deploy target, env vars, verification
│   └── adrs/           # Architectural Decision Records
│       └── ADR-000-template.md
└── templates/          # Prompt and plan templates
    ├── plan-template.md        # Structured format for implementation plans
    ├── prompt-architecture.md  # Architecture design prompt
    ├── prompt-brand.md         # Brand identity guide prompt
    ├── prompt-mvp-brainstorm.md # MVP scoping prompt
    └── prompt-prd.md           # Product requirements prompt
```

### Skills (`.claude/skills/`)

| Skill | When to Use |
|---|---|
| `conductor` | Start of build phase — plan tracking and sub-agent prompt generation |
| `code-review` | After every sub-agent task, before committing |
| `security-review` | Before deployment — credential exposure, third-party code, API security |
| `update-docs` | After commit — keep docs current |
| `feature-impact` | Before building any new feature — catch edge cases early |
| `debug` | When something's broken — structured diagnosis before code changes |
| `handoff` | End of session — capture state for the next session to pick up cleanly |
| `brand-checker` | Before finishing any UI work — visual consistency |

### Git Hooks (`.githooks/`)

| Hook | What It Does |
|---|---|
| `pre-commit` | **Scope boundary enforcement.** If a `SCOPE` file exists, blocks commits touching files outside listed directories. Opt-in — no `SCOPE` file means no enforcement. |

**Setup:** After cloning, point git at the hooks directory:

```bash
git config core.hooksPath .githooks
```

**SCOPE file format** (create in repo root when you want to lock edits to specific directories):

```
# One directory per line, relative to repo root
src/agents/
config/
docs/plans/
```

When you're done with the focused session, delete the SCOPE file to remove the boundary. The SCOPE file is gitignored — it's session-specific and never committed.

### Root Files

| File | Purpose |
|---|---|
| `CLAUDE.md` | Project-specific rules for Claude Code (customize per project) |
| `spec.md` | Living roadmap — overview, architecture, deployments, dependencies, installed skills, certification status, change log |
| `.gitignore` | Standard ignores for Node/TypeScript/Cloudflare projects |
| `.env.example` | Safe template for secrets — list every key with empty values |
| `SCOPE` | (optional, gitignored) Session-specific directory allowlist for pre-commit scope enforcement |

### Legacy projects (pre-2026-04-22)

Projects scaffolded from this template **before 2026-04-22** do not have a `spec.md` and are deliberately not being retrofitted. New projects get the spec; old projects keep whatever docs they have. If a legacy project ever needs a spec later, copy `spec.md` from this template manually and backfill — don't treat retrofit as a required migration.

## Planning Phase Workflow (from your colleague's guide)

1. **Create PRD** — Use the PRD prompt with your client/stakeholder
2. **Visual prototype** — Lovable or similar, validate the concept
3. **Brand guide** — Extract brand identity into `brand.md`
4. **Architecture** — Generate `docs/tech/architecture.md`
5. **Implementation plan** — Use `docs/templates/plan-template.md`, create plan in `docs/plans/`
6. **Run /init** — Let Claude Code scan the project, then trim the CLAUDE.md

## Build Phase Workflow

0. **Deploy hello world first** — Get the full lifecycle working before writing feature code. Fill in `docs/tech/deployment.md`
1. **Open conductor terminal** — Use the conductor skill prompt
2. **Conductor generates sub-agent prompt** — Review it, add context if needed
3. **/clear a terminal, paste the prompt** — Watch the sub-agent build
4. **Sub-agent finishes → You test manually → Code review → Security review (if applicable) → Commit → Update docs**
5. **Report back to conductor** — What was done, what deviated, what came up
6. **Conductor generates next prompt** — Repeat
7. **End of session → Write handoff** — Use the handoff skill

## CLAUDE.md Maintenance Rules

After running /init, hand-edit your CLAUDE.md:
* Cut anything the AI can discover from code (directory structure, frameworks, dependency lists)
* Keep undiscoverable stuff (why decisions were made, which pattern is canonical, project-specific conventions)
* Use it as an index — point to deeper docs rather than inlining
* Move enforceable rules to automation — linting/formatting go in pre-commit hooks, not prose
* Review regularly — the AI will add things over time, trim the fat

## Branching

Default: work directly on main. The conductor/sub-agent cycle with frequent commits gives you enough save points for day-to-day work. Only reach for `git branch` or `git worktree` when you're doing exploratory work you might throw away, touching risky systems (auth, database migrations, core architecture), or running a big refactor that will leave the project broken for a while.

## Global Settings

Your universal preferences live in `~/.claude/CLAUDE.md` (separate file, not in this repo). That file loads into every project automatically and contains your personal working style, security rules, and process preferences.

## Obsidian Tip

Symlink `docs/features/` to a folder in your Obsidian vault:

```
ln -s /path/to/obsidian/vault/my-project/project-context docs/features
```

Claude Code reads/writes them as project files. You read/edit them in Obsidian with full markdown rendering.

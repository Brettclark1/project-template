# Project Starter Template — SmokedBaconAI

This is the standard project scaffold for Everyday Workflow LLC projects. Clone this to start any new project with the right structure, docs, and skills already in place.

## Quick Start

```bash
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
├── plans/              # Active implementation plans
│   ├── completed/      # Move plans here when done
│   └── README.md       # Explains the plan workflow
├── features/           # 30,000-foot product capabilities
│   ├── overview.md     # What the product does
│   └── CHANGELOG.md    # High-level change log
└── tech/               # Technical reference
    ├── architecture.md # System design
    └── adrs/           # Architectural Decision Records
        └── ADR-000-template.md
```

### Skills (`.claude/skills/`)
| Skill | When to Use |
|-------|-------------|
| `conductor` | Start of build phase — plan tracking and sub-agent prompt generation |
| `code-review` | After every sub-agent task, before committing |
| `update-docs` | After commit — keep docs current |
| `feature-impact` | Before building any new feature — catch edge cases early |
| `brand-checker` | Before finishing any UI work — visual consistency |

### Root Files
| File | Purpose |
|------|---------|
| `CLAUDE.md` | Project-specific rules for Claude Code (customize per project) |
| `.gitignore` | Standard ignores for Node/TypeScript projects |
| `.env.example` | Safe template for secrets |

## Planning Phase Workflow (from your colleague's guide)

1. **Create PRD** — Use the PRD prompt with your client/stakeholder
2. **Visual prototype** — Lovable or similar, validate the concept
3. **Brand guide** — Extract brand identity into `brand.md`
4. **Architecture** — Generate `docs/tech/architecture.md`
5. **Implementation plan** — Brainstorm MVP scope, create plan in `docs/plans/`
6. **Run /init** — Let Claude Code scan the project, then trim the CLAUDE.md

## Build Phase Workflow

1. **Open conductor terminal** — Use the conductor skill prompt
2. **Conductor generates sub-agent prompt** — Review it, add context if needed
3. **/clear a terminal, paste the prompt** — Watch the sub-agent build
4. **Sub-agent finishes** → Code review → Commit → Update docs
5. **Report back to conductor** — What was done, what deviated, what came up
6. **Conductor generates next prompt** — Repeat

## CLAUDE.md Maintenance Rules

After running /init, hand-edit your CLAUDE.md:
- **Cut** anything the AI can discover from code (directory structure, frameworks, dependency lists)
- **Keep** undiscoverable stuff (why decisions were made, which pattern is canonical, project-specific conventions)
- **Use it as an index** — point to deeper docs rather than inlining
- **Move enforceable rules to automation** — linting/formatting go in pre-commit hooks, not prose
- **Review regularly** — the AI will add things over time, trim the fat

## Global Settings

Your universal preferences live in `~/.claude/CLAUDE.md` (separate file, not in this repo). That file loads into every project automatically and contains your personal working style, security rules, and process preferences.

## Obsidian Tip

Symlink `docs/features/` to a folder in your Obsidian vault:
```bash
ln -s /path/to/obsidian/vault/my-project/project-context docs/features
```
Claude Code reads/writes them as project files. You read/edit them in Obsidian with full markdown rendering.

# Clark's Operating Context — Paste This Into Every New Thread

---

## Who I Am

I'm Clark, founder of Ryven (Ryven.AI), an applied AI consultancy. Smoked Bacon AI (SmokedBaconAI.dev) is the research and development arm — it gets a small tasteful credit on research documents, not the spotlight.

I architect systems. I direct the design, set guardrails, and make all decisions. AI tools generate the code while I direct the architecture. I understand systems architecture, how components connect, automated pipelines, cloud infrastructure (Cloudflare Workers, KV, R2, D1), scheduled tasks, rclone syncing, API proxies, and how to manage AI agents in production. I'm a returning technologist — deep in programming 20 years ago, drawn back in by AI in 2022. I learn quickly. Where I still need support is writing code from scratch.

I'm based in Arizona (MST, no daylight saving time). Automated tasks should run silently in the background.

---

## What Ryven Does

Ryven designs, builds, and deploys applied AI systems, automation architecture, and AI infrastructure that deliver measurable operational improvements. The work spans:

- **AI readiness and demand stewardship** — Auditing and preparing businesses for AI-driven discovery and agent commerce (flagship product, has its own North Star in project docs)
- **Client website design and development** — Building web presences for clients
- **Automation architecture** — Pipelines, scheduled tasks, agent orchestration, API integrations
- **AI infrastructure** — Agent systems in production, MCP servers, Cloudflare Workers deployments
- **Applied AI consulting** — Helping businesses understand and implement AI systems for real operations

Each project has its own context and goals. The handoff doc for a given project contains the project-specific vision, North Star, and priorities. This operating context covers how I work across ALL projects.

---

## How I Work — Rules for Every Session

*These are my default working preferences. I override them in-session when the situation calls for it. The only rules that never bend are security rules.*

**Decision making:**
- One change at a time. Always explain what a change does and get my approval before making it.
- Tell me what NOT to do, not just what to do — guardrails matter more than instructions.
- Simple, reliable solutions over complex or clever ones.
- Explain new technical concepts when they come up, but don't over-explain things I've already learned.
- When I ask a question about what something is or how it works, teach me. I want to understand what I'm building.

**Code and commands:**
- When actions need to happen on my local machine, give me the ready-to-run PowerShell command — don't just describe the steps.
- When giving me prompts or instructions to paste into Claude Code, write them as plain natural language text — never put them in a code block or formatted box.
- Only use code blocks for actual commands I run in PowerShell or terminal.
- Keep commands and instructions in separate blocks — never mix directions with things I need to copy.

**Security — non-negotiable:**
- Never expose API keys, tokens, or credentials in code, logs, or chat.
- Minimize copies of credentials — every copy is an attack surface.
- Flag security risks proactively, even if I didn't ask.
- When building for clients, always consider encrypted storage, key rotation, least privilege access, and audit trails.
- For any third-party skill, tool, or dependency: review the full source code for outbound data calls, hardcoded URLs, obfuscated code, and credential access before recommending it. If the source can't be fully reviewed, build custom instead. Security of the closed system is more important than saving development time.

**Documentation discipline:**
- Remind me to update project documentation after changes.
- Every commit gets a CHANGELOG.md entry.
- CLAUDE.md gets updated when changes affect how the project works, guardrails, or context a future session needs.
- docs/tech/architecture.md gets updated on structural changes.
- Session handoff doc at end of every working session.

**API integrations:**
- When a PRD involves external APIs, flag any integration details that haven't been tested with a live call. Mark them as ASSUMED so the build phase knows to verify before coding against them.

---

## My Development Environment

**Local machine:** Windows (MacBook Pro M5 arriving soon for migration)
**Editor:** VS Code + Claude Code
**Terminal:** PowerShell
**Runtime:** Node v20, Wrangler 4.74
**Cloud platform:** Cloudflare (Workers, KV, R2, D1, Rate Limiting API)
**Version control:** GitHub (github.com/Brettclark1)
**Accounts:** Firecrawl (paid monthly), Apify (available for evaluation), Google Cloud (Places API, PageSpeed API)

---

## How I Build Projects

### Project Template
My standard project template lives at `C:\Users\clark\project-template` (GitHub: Brettclark1/project-template). When scaffolding a new project, use that template for structure — don't ask me to upload files.

The template includes:
- `.claude/skills/` — Claude Code skills (debug, security-review, handoff, conductor, plus standard skills)
- `docs/` structure: `plans/`, `features/`, `tech/adrs/`, `templates/`, `handoffs/`
- `.env.example`, `.gitignore`, `README.md`
- `CLAUDE.md` — project rules and guardrails for Claude Code

### How I Use Claude Code
- I work in Claude Code as my primary build environment
- I use `/skills` to invoke project-specific and personal skills
- Before starting work, Claude Code should read `.claude/skills/` and `CLAUDE.md` for project context
- I use the conductor skill pattern for complex multi-step work — defined sub-agent prompt structure with 7 required sections
- I orchestrate work across threads: build thread, research thread, skills management thread — each with its own handoff doc

### How I Use Agents
- I spin off parallel Claude Code agents for independent tasks using conductor.build (Mac) or separate terminal sessions
- Each agent gets a specific, scoped task with clear inputs and outputs
- Agents report back; I review and approve before anything gets committed
- The conductor skill defines the sub-agent prompt structure

### Cloudflare Architecture Pattern
My default deployment pattern:
- **Cloudflare Workers** — compute (ES modules, multi-file src/ with wrangler bundling)
- **KV** — config and fast lookups (scoring config, feature flags, registries)
- **R2** — object storage (reports, static assets, backups)
- **D1** — SQLite database (metadata, historical data, structured queries)
- **Rate Limiting API** — binding in wrangler.toml, not dashboard WAF (workers.dev domains can't use zone-level WAF)
- **Secrets** — `wrangler secret put` for API keys, never in code or wrangler.toml
- **wrangler.toml** — the blueprint that declares all bindings. Resource IDs are fine in here. Secrets are never in here.

### Config-Driven Architecture
- Scoring weights, thresholds, platform modifiers, crawler lists, industry profiles — all in KV config, not code
- New features and checks should be config changes when possible, not code changes
- The Intelligence Agent (future) writes to config, never to code
- Industry profiles enable per-vertical customization without rebuilds

---

## Current Active Projects

### AI Readiness Audit Tool (Brettclark1/ai-readiness-audit)
- Flagship product for AI readiness and demand stewardship
- Has its own North Star (diagnose → remediate → enable → steward lifecycle)
- Full project context in the project's handoff docs and CLAUDE.md
- Phase 2 core complete, security hardened, integration tested

### Project Template (Brettclark1/project-template — public)
- Standard scaffolding for all new projects
- Claude Code skills: debug, security-review, handoff, conductor
- Clone this for every new project

### Client Projects
- Vary by engagement. Each gets its own repo, its own CLAUDE.md, its own handoff docs.
- Always scaffolded from the project template.

*When starting a session for a specific project, always provide the project's handoff doc alongside this operating context.*

---

## Key Principles

- **Separation of concerns.** Components that fetch data don't score or decide. Components that score don't fetch. Keep responsibilities clean.
- **Config-driven everything.** If it can be a config change instead of a code change, it's config. Weights, thresholds, feature flags, registries, templates — all config.
- **Security is architecture, not afterthought.** Least privilege, encrypted storage, key rotation, audit trails. Every copy of a credential is an attack surface.
- **Speed to market over feature completeness.** Ship what works, add incrementally. Don't polish what hasn't been validated.
- **Build for the operator (me) first.** One person plus AI agents serving clients. Everything should be automatable, scriptable, and monitorable. No manual steps that could be automated.
- **Document as you go.** The next session — or the next agent — should pick up clean without asking what happened.

---

## When Starting a New Session

Every new thread gets TWO documents:

1. **This Operating Context** — universal, covers how I work (paste first)
2. **The Project Handoff Doc** — project-specific, covers what we're building and where we left off (paste second)

Then:
3. If working in Claude Code, read `CLAUDE.md` and `.claude/skills/` before touching any code
4. Ask what I want to work on — don't assume from the handoff doc
5. If making changes, show me what you're changing and get approval before committing

**Available handoff docs by workstream:**
- AI Readiness Audit Tool build → `SESSION-HANDOFF-2026-03-17-phase2-validation.md`
- Agentic Commerce Research → `HANDOFF-agentic-commerce-research.md`
- Claude Code Skills Catalog → `HANDOFF-skills-catalog-project.md`
- New project → start from the project template, create a new handoff as we go

---

*Ryven — Applied AI Consultancy — Ryven.AI*
*Research: Smoked Bacon AI — SmokedBaconAI.dev*

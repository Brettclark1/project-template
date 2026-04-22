---
project_name: <!-- e.g., mirofish -->
created: <!-- YYYY-MM-DD -->
last_updated: <!-- YYYY-MM-DD -->
certification_status: UNCERTIFIED
---

# Project Spec — <!-- PROJECT NAME -->

> **Living roadmap.** Update this file after any material change — new component, new deployment, new external dependency, certification status change. If the project state and this file disagree, this file is wrong. Fix it.

## Project Overview
<!--
One to three paragraphs. Answer:
- What does this project do?
- Who does it serve (internal Ryven tool? client deliverable? public product?)
- What problem does it solve, and why does it exist?
- Link the PRD if one exists: docs/tech/prd.md or ryven-brain/projects/{project}/...
-->

## Architecture
<!--
High-level map of what exists and where. List each major component with its
file path in this repo. Keep it to surfaces, not implementation detail — point
at docs/tech/architecture.md for the full design.

Example:
- **API worker** — src/api/ (Cloudflare Worker, handles REST endpoints)
- **Scheduler** — src/scheduler/ (cron-triggered tasks)
- **Database layer** — src/db/ (Postgres via Hyperdrive)
- **Frontend** — web/ (separate repo: Brettclark1/{project}-web)

See docs/tech/architecture.md for full system design and data flow.
-->

## Deployments
<!--
What's deployed, where, and how to find it. One row per deployed artifact.

| Component | Platform | URL / Identifier | Notes |
|---|---|---|---|
| API worker | Cloudflare Workers | api.example.com | wrangler deploy |
| Static site | Cloudflare Pages | example.com | auto-deploy from main |
| Cron worker | Cloudflare Workers | (no public URL) | runs every 15 min |

Include the deploy command and health-check endpoint for each. Full detail
lives in docs/tech/deployment.md.
-->

## External Dependencies
<!--
Third-party services, APIs, and SaaS tools this project relies on at runtime
or build time. For each, note what it's used for, where credentials live, and
whether it's been live-tested (VERIFIED) or taken on faith (ASSUMED).

| Service | Used for | Credential location | Status |
|---|---|---|---|
| Stripe | payments | 1Password / Wrangler secret STRIPE_KEY | VERIFIED |
| Zernio | publishing | 1Password / Wrangler secret ZERNIO_KEY | ASSUMED |
| Supabase | auth + db | .env SUPABASE_URL, SUPABASE_ANON_KEY | VERIFIED |

Flag the brittle ones — services without SLAs, APIs in beta, anything that
could disappear and break the project.
-->

## Installed Skills and Automations
<!--
Which Claude Code skills are installed in this project's .claude/skills/ (or
available via gstack/global), and which Cowork tasks, Routines, or crons
touch this project.

Skills installed in-repo (.claude/skills/):
- conductor
- code-review
- security-review
- ...

Cowork tasks / Routines that touch this project:
- Morning standup — reads handoffs from docs/handoffs/
- Weekly retro cron — runs /retro every Friday 4pm
- ...

This section matters for security review: any automation that touches this
repo is part of its attack surface.
-->

## Certification Status
<!--
One of three allowed values (also set in frontmatter):

- **CERTIFIED** — Full Build Certification Package present: comprehension artifacts,
  semantic rules, context packages, liability review signed. Safe to hand to a
  client or defend in a legal review.
- **UNCERTIFIED** — In progress. Some or all certification artifacts missing.
  Most projects will sit here during active build.
- **INTERNAL** — Deliberately not certified. Internal Ryven tooling, experiments,
  or throwaway projects where certification overhead isn't justified. Flag this
  intentionally — do not use as a way to skip certification on client work.

When changing status, add a Change Log entry below with the date, the new status,
and the reason.
-->

**Current status:** UNCERTIFIED <!-- change to match frontmatter -->

## Change Log
<!--
Dated entries when material changes happen. Newest on top. One line per entry,
or a short bullet list if a single change touched multiple sections. This is
the human-readable audit trail for the spec itself.

Material changes include:
- New component added to Architecture
- New deployment target
- New external dependency
- Certification status change
- Major scope or ownership change

Example:
### 2026-04-22
- Initial spec created from project-template.

### 2026-05-10
- Added Stripe ACP integration (External Dependencies).
- Added Cloudflare Pages frontend deployment.
- Certification status: UNCERTIFIED (blocked on liability-review).
-->

### <!-- YYYY-MM-DD -->
- Initial spec created from project-template.

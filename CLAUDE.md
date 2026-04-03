# CLAUDE.md — [PROJECT NAME]

## Project Overview
<!-- One sentence: what this project does and who it's for -->

## Quick Reference
- **Stack:** <!-- e.g., TypeScript, Next.js, Supabase, Tailwind -->
- **Run dev:** <!-- e.g., npm run dev -->
- **Run tests:** <!-- e.g., npm test -->
- **Build:** <!-- e.g., npm run build -->
- **Deploy:** <!-- e.g., npx wrangler deploy -->
- **CLI tools available:** <!-- e.g., wrangler, gh, stripe, vercel -->

## Active Integrations (MCPs)
<!-- List MCP connections available in this project's Claude Code setup. -->
<!-- The AI forgets it has MCP access — sub-agent prompts should remind it. -->
<!-- Format: what it connects to, what to use it for, when to check it. -->
<!--
- Supabase MCP — check actual schema before assuming table structure
- GitHub MCP — verify issue status, create PRs
-->

## Architecture
See `docs/tech/architecture.md` for full system design.
See `docs/tech/deployment.md` for deployment target, env vars, and deploy verification.

## Key Decisions
See `docs/tech/adrs/` for architectural decision records.

## Current Phase
<!-- What are we working on right now? Link to active plan. -->
See `docs/plans/` for active implementation plans.

## Project Conventions
<!-- Only put things here the AI can't discover from the code. -->
<!-- Examples: -->
<!-- - We use X pattern for Y because Z -->
<!-- - Error messages follow this format: ... -->
<!-- - All API responses use this shape: ... -->

## What NOT to Do
<!-- Guardrails specific to this project -->
<!-- - Don't modify the scoring algorithm without discussing first -->
<!-- - Don't add new dependencies without approval -->
<!-- - Don't change the database schema without an ADR -->

## npm Security Rules (non-negotiable)
- Exact version pinning only in package.json — no carets (`^`) or tildes (`~`)
- Use `npm ci` instead of `npm install` in all scripted or automated builds
- Always commit `package-lock.json` — never add it to `.gitignore`
- Never add new npm dependencies without Brett's explicit approval

## Living Systems Layer (Build Gate)
Every build must include a Living Systems Layer. If a PRD or Architecture doc does not contain a Living Systems Layer section, the spec is incomplete. Do not proceed to scaffold. Reference: `doctrine/living-systems-layer-prd-v3.md`

## gstack
Available skills: /office-hours, /plan-ceo-review, /plan-eng-review, /plan-design-review, /design-consultation, /design-shotgun, /design-html, /review, /ship, /land-and-deploy, /canary, /benchmark, /browse, /connect-chrome, /qa, /qa-only, /design-review, /setup-browser-cookies, /setup-deploy, /retro, /investigate, /document-release, /codex, /cso, /autoplan, /careful, /freeze, /guard, /unfreeze, /gstack-upgrade, /learn.

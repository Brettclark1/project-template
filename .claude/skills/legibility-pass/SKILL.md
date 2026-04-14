---
name: legibility-pass
description: Generate a comprehension artifact at the end of every build cycle, while the building sub-agent's context is still fully loaded. Captures what the module does, what it touches, what it deliberately does not touch, load-bearing assumptions, rejected alternatives, and a comprehension gate. Runs as a mandatory pipeline gate between security-review and commit. Part of the Ryven Build Certification Framework.
---

# Skill: Legibility Pass

## When to Use
At the end of every build cycle, after `code-review` and `security-review` have passed, before `commit`. The sub-agent that built the module generates the artifact while its context is still fully loaded — this is the only moment when reasoning can be captured accurately, not reconstructed later.

This is a **mandatory pipeline gate**. The conductor cannot mark a build complete without it. See `.claude/skills/conductor/SKILL.md` for the pipeline and `ryven-brain/doctrine/ryven-build-certification.md` for the full framework.

## Instructions

Write one comprehension artifact per module just built, saved to `docs/comprehension/{module-name}.md`. Use the building sub-agent itself (not a fresh one) — context must still be loaded.

Each artifact must contain exactly these sections:

```
MODULE: [name]
BUILT: [ISO timestamp]
TYPE: GENERATED-AT-BUILD

WHAT IT DOES:
  [2 sentences, plain English. No jargon. A non-engineer must be able
  to read this and understand what the module accomplishes.]

WHAT IT TOUCHES:
  - [explicit list of files, services, tables, APIs, env vars, queues,
    caches this module reads from or writes to]

WHAT IT DOES NOT TOUCH:
  - [explicit negative list — things a reader might assume this module
    touches but it deliberately does not. This is the most valuable
    part of the artifact for future readers.]

LOAD-BEARING ASSUMPTIONS:
  - [things that break this module if they change — schema shapes, API
    contracts, env var names, ordering guarantees, timing assumptions]

WHAT WAS REJECTED AND WHY:
  - [alternatives considered during the build and why they were not chosen.
    Include the ones that almost won — future readers need to know the
    decision was made, not stumbled into.]

AGENT FLAGS:
  - [anything uncertain during generation — ASSUMED integrations, unverified
    edge cases, open questions. Honest flags here save liability later.]

COMPREHENSION GATE:
  Founder can explain this module without reading the code: [yes / no / needs-review]
```

After writing the artifact:

1. **Update `docs/comprehension/INDEX.md`** — add a row for this module: module name, artifact filename, build date, `GENERATED-AT-BUILD`, and the one-sentence plain-English summary from WHAT IT DOES.

2. **Queue for wiki ingest** — append a line to `~/Dev/ryven-brain/raw/inbox/PENDING-INGESTS.md` in the format `| YYYY-MM-DD | comprehension/{module-name}.md | {project-name} |` so the ryven-brain wiki layer can absorb it on the next ingest pass.

3. **Report back to the conductor** with the artifact path and the COMPREHENSION GATE verdict. If the gate is `no` or `needs-review`, the conductor flags the module for founder review before marking the build task complete.

## Why This Exists
Dark code is AI-generated code that passes tests but nobody can explain. Ryven ships a certification package proving every module's reasoning was captured at build time — not reconstructed 18 months later under audit pressure. This skill is the keystone that produces that evidence. A timestamped artifact written by the agent that did the work is liability-grade proof; a reconstruction from git history is not.

## What NOT to Do
- Don't generate the artifact in a fresh sub-agent. The reasoning is already lost once context is cleared. Always use the building agent, at the end of its session, before commit.
- Don't skip the negative list (WHAT IT DOES NOT TOUCH). It tells future readers which boundaries were intentional — the single most useful thing a new agent can learn before touching this module.
- Don't pad LOAD-BEARING ASSUMPTIONS with everything. List only things that would actually break the module if they changed. A list of 30 weak assumptions is worse than a list of 5 real ones.
- Don't mark the COMPREHENSION GATE `yes` on the agent's own authority. The agent does not declare what the founder understands. `yes` is a claim that the artifact is clear enough for the founder to explain — the founder verifies at `liability-review` time.
- Don't mark an artifact `GENERATED-AT-BUILD` if it was reconstructed from git history after the fact. That is `RECONSTRUCTED` and belongs to `dark-audit`, not this skill. The two types exist precisely to keep this distinction honest.
- Don't commit the module if the artifact is missing. This is a hard pipeline gate — the conductor rejects the completion report without it.

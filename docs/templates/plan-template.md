# Plan Template

Use this structure for implementation plans in `docs/plans/`. The conductor reads these to generate sub-agent prompts, so the format matters — structured tasks with clear boundaries make better prompts.

---

# Implementation Plan: [Feature Name]

**Created:** YYYY-MM-DD
**Status:** Active | Paused | Complete
**Depends on:** [List any prerequisites — other plans, API verifications, decisions needed]

## Goal
<!-- One sentence: what does "done" look like when this plan is fully executed? -->

## Scope
<!-- What's IN this plan and what's explicitly OUT. Prevents scope creep during build. -->

**In scope:**
- 

**Out of scope:**
- 

## Tasks

Each task should be completable by a single sub-agent in one session without running out of context. If a task is too big, break it into sub-tasks.

### Task 1: [Name]
- **What:** <!-- What to build or change -->
- **Files:** <!-- Which files to create, modify, or read -->
- **Depends on:** <!-- Previous tasks that must be complete, or "none" -->
- **Produces:** <!-- What exists when this task is done — a file, an endpoint, a config -->
- **Acceptance:** <!-- How to verify it's done correctly — what to run, what to check -->
- **Status:** Not started | In progress | Complete | Blocked
- **Notes:** <!-- Gotchas, constraints, ASSUMED items to verify -->

### Task 2: [Name]
- **What:**
- **Files:**
- **Depends on:**
- **Produces:**
- **Acceptance:**
- **Status:** Not started
- **Notes:**

<!-- Add more tasks as needed -->

## ASSUMED Items
<!-- List anything marked ASSUMED that must be verified before or during the build. -->
<!-- Each should reference which task depends on it. -->

| Assumption | Depends on by | Verification method | Verified? |
|---|---|---|---|
| | Task N | | No |

## Decisions Needed
<!-- Anything that requires a human decision before a task can proceed. -->

| Decision | Blocks task | Options | Decided? |
|---|---|---|---|
| | Task N | | No |

## Post-Build
- [ ] All tasks complete
- [ ] Security review run (`.claude/skills/security-review/`)
- [ ] Docs updated
- [ ] Plan moved to `docs/plans/completed/`

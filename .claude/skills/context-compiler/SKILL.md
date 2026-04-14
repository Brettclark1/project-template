---
name: context-compiler
description: Assemble the full context package a sub-agent receives before writing a single line of code. Pulls relevant comprehension artifacts, semantic rules, architectural decisions, and negative context for the modules being touched. Validates completeness before handing the package to the conductor. Runs before any build starts. Part of the Ryven Build Certification Framework.
---

# Skill: Context Compiler

## When to Use
Before any build task starts — after the conductor has chosen the next chunk of work but before the sub-agent prompt is dispatched. One context package per build task, saved to `docs/context-packages/{build-id}.md`.

See `ryven-brain/doctrine/ryven-build-certification.md` for the full framework.

## Instructions

### Inputs
The conductor provides:
- `build_id` — kebab-case identifier for this task (reuse the `task_id` used by the evaluator)
- `target_modules` — the files or modules this task will touch
- `task_description` — one-line statement of what will be built

### Assembly
Compile the package in this order. Every section is required. Sections with no applicable content are included with the literal note `(none applicable for this task)` — silence is indistinguishable from "not checked".

```
# CONTEXT PACKAGE — {build_id}
COMPILED: [ISO timestamp]
TARGET MODULES: [list from conductor]
TASK: [one-line description]

## 1. Relevant Comprehension Artifacts
For every `target_module` that has an existing artifact in `docs/comprehension/`,
include the full artifact here — not a reference, the full text. The sub-agent
should not need a second read to see prior reasoning.

Also include comprehension artifacts for modules the target modules directly
depend on (imports, API calls, schema references, shared state). This is the
"prior reasoning" layer — what the agent must respect from earlier builds.

## 2. Applicable Semantic Rules
Walk `docs/semantic-context/` and include every rule whose BOUNDARY overlaps
with the target modules. Err on the side of including more rather than fewer.
Each rule goes in full (RULE / WHY / BOUNDARY / FAILURE MODE).

## 3. Architectural Decisions
Pull any ADRs from `docs/tech/adrs/` or equivalent that touch the target area.
Include in full so the sub-agent reasons from the original decision, not a
summary.

## 4. Negative Context
Things the sub-agent must NOT touch during this task. Sources:
  - "WHAT IT DOES NOT TOUCH" negative lists from the comprehension artifacts above
  - The conductor's own "What NOT to touch" section of the sub-agent prompt
  - The project's CLAUDE.md "What NOT to Do" section
  - Any open `SCOPE` file in the repo root

## 5. ASSUMED Integrations
Anything in this build that depends on an external service, API, or config
that has NOT been verified with a live call. List each one and mark it
ASSUMED. The sub-agent must verify these before building against them.

## 6. Validation Checklist
[ ] Every target_module has either a comprehension artifact or an explicit
    "greenfield module — no prior artifact exists" note
[ ] Semantic rules section is populated or explicitly marked (none applicable)
[ ] Negative context lists at least the project CLAUDE.md guardrails
[ ] Every ASSUMED integration is named and flagged
```

### Validation
Before handing the package to the conductor, walk the checklist. If any item fails validation, do not dispatch — surface the gap to the conductor so it can either fill the gap (commission a `dark-audit` reconstruction for a missing artifact, write a semantic rule for an unstated constraint) or explicitly accept the gap and record the acceptance inside the package.

### Delivery
Save the compiled package to `docs/context-packages/{build_id}.md` and return its path to the conductor. The conductor pastes the package into the sub-agent prompt's Context section before adding task-specific instructions.

## Why This Exists
Dark code is a context failure, not a model failure. An agent handed a thin prompt optimizes for "working" over "comprehensible" because it does not know what prior reasoning it should respect. An agent handed a compiled context package — artifacts for the modules it is touching, semantic rules for the boundaries in play, and an explicit negative list — produces code consistent with everything built before it.

A context package is also the answer to "what did the agent know when it wrote this?" at audit time. Without one, the answer is "we don't know". With one, the answer is "exactly this file, at this timestamp".

## What NOT to Do
- Don't paste references instead of content. A link to `docs/comprehension/user-auth.md` is useless if the sub-agent's context clears before it follows the link. Inline the full artifact.
- Don't silently drop sections. Every section is required. An empty section with `(none applicable)` is a statement; a missing section is a failure.
- Don't skip negative context because "it should be obvious". If negative context were obvious, the prior incident that made us build this skill would never have happened.
- Don't let a greenfield module bypass the package. A new module with no prior artifact still gets a package — the package just says "greenfield, no prior artifact, respect these semantic rules and this architectural direction".
- Don't run the compiler inside the sub-agent's terminal. This is a conductor-side tool — it assembles the package before the sub-agent is dispatched, in the conductor's own context.
- Don't compile lazily. If a semantic rule might plausibly apply, include it. The cost of including an irrelevant rule is a few hundred tokens; the cost of omitting a relevant one is a bug built on top of a boundary the agent never saw.

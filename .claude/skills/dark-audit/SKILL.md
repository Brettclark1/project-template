---
name: dark-audit
description: Scan all modules in the project against the comprehension index, flag modules with no artifact as dark, and produce RECONSTRUCTED artifacts for them by reading code, git history, and CLAUDE.md. Produces a dark code map showing which modules have build-time artifacts, which are reconstructed, and which remain uncovered. Run on demand and quarterly at minimum. Part of the Ryven Build Certification Framework.
---

# Skill: Dark Audit

## When to Use
- **On demand** — when a client asks for an audit, when a founder attestation is upcoming, or when Brett wants a current exposure map
- **Quarterly at minimum** — to keep drift from accumulating silently
- **Before any `liability-review`** — so the founder attests with a current map, not a stale one

See `ryven-brain/doctrine/ryven-build-certification.md` for the full framework.

## Instructions

### Phase 1 — Inventory
Walk the project and list every module that would be expected to have a comprehension artifact. A module is loosely whatever unit of code a senior engineer would want to read as a single thing — one file, one service, one worker, one agent, one schema, or a tight cluster of related files.

### Phase 2 — Match against the index
For each module, check `docs/comprehension/` for an existing artifact. Classify as:

- **HOT** — artifact exists and is marked `GENERATED-AT-BUILD`
- **RECONSTRUCTED** — artifact exists and is marked `RECONSTRUCTED`
- **DARK** — no artifact exists

### Phase 3 — Best-effort reconstruction for DARK modules
For every DARK module, attempt to produce a reconstructed artifact by reading:

- The module's source code
- Relevant git history (`git log --follow`, `git blame` on key lines, commit messages near module introduction)
- Project `CLAUDE.md` and any referenced docs
- Architecture doc, ADRs, and any related comprehension artifacts that touch this module

Write the reconstructed artifact to `docs/comprehension/{module-name}.md` in the same format `legibility-pass` uses, with two critical differences:

- `TYPE: RECONSTRUCTED` (not `GENERATED-AT-BUILD`)
- Add a `RECONSTRUCTION NOTES` section at the bottom listing sources consulted and any sections that could not be confidently reconstructed. Mark those as `UNKNOWN — needs founder review`.

### Phase 4 — Write the audit report
Save a dated audit report to `docs/comprehension/DARK-AUDIT-{YYYY-MM-DD}.md` containing:

- **Totals** — count of HOT, RECONSTRUCTED, DARK modules (before and after this audit)
- **Dark code map** — table of every module with its classification
- **Newly reconstructed** — list of modules reconstructed in this audit with a one-line confidence note for each
- **Still dark** — list of modules where reconstruction was refused (too complex, too uncertain, insufficient history); each entry explains why it could not be reconstructed
- **Exposure summary** — one paragraph for Brett: where is the real liability risk, what should be rebuilt with a real `legibility-pass`, what is safe to leave as reconstructed

### Phase 5 — Update the index
Update `docs/comprehension/INDEX.md` to reflect every new or updated artifact. Mark reconstructed entries clearly with `RECONSTRUCTED` in the type column so readers immediately know the fidelity level.

## Why This Exists
Ignorance is not a defense. If a client asks "what don't you understand about the system you built us?", the answer must be a remediation map, not a shrug. The dark audit proves Ryven knows where its exposure is and is actively narrowing it.

Reconstructed artifacts are lower fidelity than build-time artifacts, but they are infinitely better than nothing — and they tell the founder exactly which modules still need a real `legibility-pass` re-run to reach full certification.

## What NOT to Do
- Don't mark a reconstructed artifact as `GENERATED-AT-BUILD`. The whole point of the two types is to distinguish what was captured live from what was inferred later. Lying about the type undermines the entire certification.
- Don't fabricate content to fill a section. If LOAD-BEARING ASSUMPTIONS cannot be confidently reconstructed for a module, leave it as `UNKNOWN — needs founder review`. An honest `UNKNOWN` is liability-safe; a plausible-sounding guess is not.
- Don't run the audit inside the building sub-agent's terminal. Use a fresh context — the audit must be an independent read, same rule as the evaluator.
- Don't delete or overwrite a prior dark audit report. New reports get new dated filenames so the history of exposure over time is visible and the trend is auditable.
- Don't skip the "Still dark" list because it looks bad. The list of modules you could not reconstruct is the most important paragraph in the report — it is the precise map of remaining liability.

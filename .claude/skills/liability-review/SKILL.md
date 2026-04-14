---
name: liability-review
description: Produce the founder attestation report before any client delivery. Summarizes what was built, what review processes ran, what is ASSUMED vs VERIFIED, what the founder must be able to explain verbally, and what outstanding uncertainties exist. Saves to docs/liability-reviews/. This is the document Ryven files and keeps as the liability instrument. Part of the Ryven Build Certification Framework.
---

# Skill: Liability Review

## When to Use
Before any delivery of work to a client. Not optional, not skippable, not something to do "next week". The report must be written and signed before the delivery email goes out, before the PR merges to the client's repo, and before any access handoff happens.

Run a `dark-audit` first if one has not been run recently — the liability review relies on an accurate, current comprehension index.

See `ryven-brain/doctrine/ryven-build-certification.md` for the full framework.

## Instructions

Write one report per delivery, saved to `docs/liability-reviews/{client}-{YYYY-MM-DD}.md`. Use this exact structure:

```
ENGAGEMENT: [client / project name]
DELIVERY DATE: [YYYY-MM-DD]
FOUNDER: Brett Clark, Ryven.AI

WHAT WAS BUILT:
  [Plain-English summary. 3–8 sentences. A non-engineer reading this must
  understand the shape of what shipped. No jargon, no file paths, no class
  names — describe behavior and outcomes.]

REVIEW PROCESSES RUN:
  [ ] code-review
  [ ] security-review
  [ ] legibility-pass (one per module)
  [ ] semantic-rules (updated for any new constraints)
  [ ] context-compiler (one per build task)
  [ ] dark-audit (date of most recent: YYYY-MM-DD)

ASSUMED (not yet verified with live call):
  - [every external integration, API, or behavior built against a spec
    but NOT confirmed with a real call against the real system]

VERIFIED (tested against live systems):
  - [every integration that HAS been exercised end-to-end against real
    systems, with the date of the verification]

FOUNDER COMPREHENSION ATTESTATION:
  Modules the founder can explain verbally without reading code:
    - [pulled from docs/comprehension/INDEX.md where COMPREHENSION GATE == yes
      AND the founder has verbally confirmed]
  Modules requiring further review before attestation:
    - [pulled from INDEX.md where the gate is no or needs-review, or where
      the founder has not yet confirmed verbally]

OUTSTANDING UNCERTAINTIES:
  - [Each item: what is uncertain, why it is uncertain, how it is being
    handled — monitored? flagged for follow-up? accepted as known-risk?]

SIGNED: Brett Clark, Ryven.AI
DATE: [YYYY-MM-DD]
```

### Workflow
1. Read `docs/comprehension/INDEX.md` to pull the full module list and comprehension gate state
2. Read the most recent `DARK-AUDIT-*.md` to confirm there are no unflagged dark modules in the delivery scope — if there are, stop and run a fresh `dark-audit` before continuing
3. Walk the project for any string marked `ASSUMED` in comments, docs, or context packages and aggregate into the ASSUMED list
4. Walk verification evidence — `docs/evaluations/`, deploy logs, test output, live-call records — for the VERIFIED list
5. Draft the report in full
6. **Hand the draft to Brett for founder review.** This skill never auto-signs. Brett reads the full report, verbally confirms the comprehension attestation list item by item, edits anything wrong, and only then signs
7. After Brett signs, save to `docs/liability-reviews/` and copy to `~/Dev/ryven-brain/intel/security/` per the global document output rules

## Why This Exists
This is the document Ryven keeps. If a client disputes what was delivered 18 months from now, if a regulator asks for an audit trail, if a downstream firm extending the system asks "what did you actually ship?" — this report is the answer. The comprehension index, semantic rules, and context packages are the evidence; the liability review is the instrument that ties them to a specific delivery on a specific date with a specific founder signature.

Most AI development agencies deliver working code. Some deliver tested code. Almost none sign a liability review that says "here is what was built, here is what was reviewed, here is what is still ASSUMED, and here is the founder's signature attesting to it." This is the product.

## What NOT to Do
- Don't auto-sign. The founder must read and verbally confirm before the signature block is filled. This is a legal-grade record, not an automated artifact — and no agent is authorized to sign on Brett's behalf.
- Don't mark an integration VERIFIED based on unit tests or mocked tests. Verified means "we hit the real system with a real call and saw the real response". Everything else is ASSUMED until proven otherwise.
- Don't omit the OUTSTANDING UNCERTAINTIES section. A report with no uncertainties is not honest — every real delivery has some. An empty uncertainties list makes the report less defensible, not more.
- Don't move a module into the "can explain verbally" list on the agent's own authority. Only Brett's verbal confirmation moves a module into that list.
- Don't edit a prior liability review. If something changes after delivery, write a dated supplement as a new file — the original report is permanent. Every liability review in `docs/liability-reviews/` is append-only.
- Don't skip the `dark-audit` prerequisite. Signing an attestation with an unknown number of dark modules in the delivery scope is signing something you cannot defend in an audit.

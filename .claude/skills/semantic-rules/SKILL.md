---
name: semantic-rules
description: Encode project rules of engagement as semantic rules — intent + boundary + failure mode — not literal instructions. Saves to docs/semantic-context/ so agents reason from meaning rather than syntax and handle novel edge cases correctly. Run whenever a new constraint, boundary, or rule of engagement is established during a build. Part of the Ryven Build Certification Framework.
---

# Skill: Semantic Rules

## When to Use
Whenever a new constraint, boundary, or rule of engagement is established during a build — the kind of rule a future sub-agent would need to know before touching this area. Trigger moments:

- A bug was caused by a class of mistake and the fix is "never do X here again"
- A decision was made about where one module's responsibility ends and another begins
- An external contract (API, schema, runtime) imposes a constraint that isn't obvious from reading the code
- Brett says "don't ever touch this without asking" in a particular area of the codebase
- A postmortem identifies a failure pattern worth codifying

See `ryven-brain/doctrine/ryven-build-certification.md` for the full framework.

## Instructions

Write one rule per file, saved to `docs/semantic-context/{rule-name}.md`. The filename is kebab-case and describes the rule's subject, not its effect (e.g., `session-token-refresh.md`, not `dont-refresh-tokens.md`).

Each rule has exactly four fields. Do not add more:

```
RULE: [one-line name of the rule]

WHY: [the problem this rule prevents. Not "because we said so" — the actual
  failure this rule was built to block. Name the incident, the class of bug,
  or the specific constraint. If you cannot state a real WHY, the rule is
  not ready to be written yet.]

BOUNDARY: [where it applies and, critically, where it explicitly does not.
  Name the file paths, modules, or conditions. A rule without a stated
  boundary gets over-applied by well-meaning agents and strangles work that
  was never the target.]

FAILURE MODE: [what breaking this rule actually looks like in production.
  Concrete. "Users get logged out mid-checkout" beats "session handling
  breaks". The failure mode is what lets a future agent judge edge cases.]
```

After writing the rule:

1. Commit it with a message naming the rule and the triggering incident or decision
2. If the rule was triggered by a specific bug, dark-audit finding, or postmortem, reference the relevant commit or doc in the commit message
3. `context-compiler` will automatically inject all semantic rules whose BOUNDARY overlaps a build's target modules — no manual wiring needed

## Why This Exists
Literal rules fail at edge cases their author never anticipated. A rule that says "always validate email addresses with regex X" fails the first time the codebase needs to accept a company's SSO-provisioned identifier that isn't an email. A semantic rule — WHY (real incident), BOUNDARY (exact applicability), FAILURE MODE (concrete production symptom) — gives the agent enough context to reason about novel situations correctly, because it knows what the rule is actually protecting against.

Rules of engagement that only live in the founder's head are not rules of engagement. They are tribal knowledge, and tribal knowledge does not survive handoff. Every semantic rule written is one less thing Ryven depends on Brett being in the room to enforce.

## What NOT to Do
- Don't write rules as commands. `RULE: never store passwords in plaintext` is a command. `RULE: credential-at-rest encryption boundary` plus the four fields is a semantic rule. Commands cannot be reasoned about at the boundary; semantic rules can.
- Don't skip BOUNDARY. Every field is non-negotiable, but BOUNDARY is where unenforced rules cause the most collateral damage. A rule meant for the auth module gets applied to every string comparison in the codebase by an over-eager agent.
- Don't bundle multiple rules into one file. One rule per file keeps them addressable and lets `context-compiler` pull exactly the relevant subset per build.
- Don't write a rule you cannot state a real WHY for. If the rule is "we just always do it this way", it isn't a rule yet — it's a preference, and it belongs in the project `CLAUDE.md`, not `semantic-context/`.
- Don't delete old rules silently. If a rule is obsolete, write a successor rule that names the obsolete one and explains what changed. Rule history is part of the liability trail — a silent deletion looks like the rule never existed.
- Don't inflate the four fields. Every word in a semantic rule gets re-read by every future agent. A 3-line FAILURE MODE that is concrete and specific beats a 20-line FAILURE MODE that is vague.

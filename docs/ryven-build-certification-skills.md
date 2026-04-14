# Ryven Build Certification Skills
**When to Run & What Each One Does**
*Last updated: 2026-04-13*

---

## The Five Certification Skills

These skills ship in every project scaffolded from `Brettclark1/project-template`. They produce the Ryven Build Certification Package — proof that every system was built with intent, not just prompted until it worked.

---

### `legibility-pass`
**Runs:** Automatically — after security-review, before every commit
**You do:** Nothing. The conductor enforces it.

Generates a comprehension artifact while the build agent's context is still hot. Captures what was built, what it touches, what it doesn't touch, load-bearing assumptions, what was rejected, and anything the agent flagged as uncertain. Saves to `docs/comprehension/{module-name}.md`. The conductor will not commit without it.

---

### `context-compiler`
**Runs:** Manually — at the start of any session where you're touching existing modules
**You do:** Before typing `/build`, ask yourself: am I extending something that was built in a previous session? If yes, tell Claude Code to run context-compiler first.

Assembles everything the sub-agent needs to know before writing a single line of code — prior comprehension artifacts, semantic rules, architectural decisions. Prevents agents from building blind against existing work. Saves to `docs/context-packages/{build-id}.md`.

**Skip it when:** Starting a brand new module from scratch with no prior session history.

---

### `semantic-rules`
**Runs:** Manually — any time a new constraint, integration, or boundary is established
**You do:** Any time you catch yourself saying "we always do it this way" or "this must never touch that" — run semantic-rules right then.

Encodes rules with embedded meaning: intent + boundary + failure mode. Not just what the rule is, but why it exists and what breaks when it's violated. Agents that read semantic rules can handle edge cases the rule author never anticipated. Saves to `docs/semantic-context/{rule-name}.md`.

**Skip it when:** Nothing new was decided this session.

---

### `dark-audit`
**Runs:** Manually — quarterly minimum (Cowork task: `dark-audit-quarterly`)
**You do:** Trigger the Cowork task every 90 days, or run it in Claude Code by saying "run dark-audit."

Scans all modules against the comprehension index. Any module without a build-time artifact is dark code. The skill attempts reconstruction for each dark module — reading code, git history, CLAUDE.md — and produces artifacts marked `RECONSTRUCTED` to distinguish them from `GENERATED-AT-BUILD`. Outputs an exposure map showing coverage across the entire project. Saves to `docs/comprehension/DARK-AUDIT-{date}.md`.

**Skip it when:** Never. Run it quarterly minimum.

---

### `liability-review`
**Runs:** Manually — before every client delivery
**You do:** Before handing anything to a client, open Claude Code in the project and say "run liability-review for [client name]." The Cowork weekly reminder (`liability-review-reminder`) will prompt you every Monday.

Produces the founder attestation report. Documents what was built, every review process that ran, what is ASSUMED vs VERIFIED, what you can explain verbally without reading the code, and what outstanding uncertainties exist. This document gets filed permanently — it is your defense if a client disputes something 18 months from now. Saves to `docs/liability-reviews/{client}-{date}.md`.

**Skip it when:** Never. No delivery goes out without it.

---

## Quick Trigger Reference

| Skill | When | How |
|---|---|---|
| `legibility-pass` | Every commit | Automatic — conductor handles it |
| `context-compiler` | Start of session touching existing modules | Tell Claude Code to run it before `/build` |
| `semantic-rules` | New constraint, integration, or boundary | Tell Claude Code to run it right when the decision is made |
| `dark-audit` | Every 90 days | Trigger Cowork task `dark-audit-quarterly` |
| `liability-review` | Before every client delivery | Tell Claude Code "run liability-review for [client]" |

---

## Where Everything Saves

| Skill | Output Location |
|---|---|
| `legibility-pass` | `docs/comprehension/{module-name}.md` |
| `context-compiler` | `docs/context-packages/{build-id}.md` |
| `semantic-rules` | `docs/semantic-context/{rule-name}.md` |
| `dark-audit` | `docs/comprehension/DARK-AUDIT-{date}.md` |
| `liability-review` | `docs/liability-reviews/{client}-{date}.md` |

---

*Ryven.AI — Applied AI systems built for real-world operations.*
*R&D: SmokedBaconAI.dev*

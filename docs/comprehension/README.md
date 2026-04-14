# docs/comprehension/

**Purpose:** Home for comprehension artifacts — the plain-English records of what each module does, what it touches, what it deliberately does not touch, and what load-bearing assumptions it relies on. One artifact per module, plus `INDEX.md` as the map of the whole system.

**Who writes here:**
- `legibility-pass` skill — at end of every build cycle, before commit. Artifact type: `GENERATED-AT-BUILD`.
- `dark-audit` skill — on demand and quarterly. Artifact type: `RECONSTRUCTED` for modules with no hot artifact.

**Who reads here:** any senior engineer arriving cold, any client auditor, any Ryven agent assembling a context package via `context-compiler`.

**Start with** `INDEX.md` — it maps every module to its artifact.

See `ryven-brain/doctrine/ryven-build-certification.md` for the full framework.

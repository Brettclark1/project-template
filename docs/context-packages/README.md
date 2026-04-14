# docs/context-packages/

**Purpose:** Home for compiled context packages — the assembled bundle of comprehension artifacts, semantic rules, architectural decisions, and negative context that every sub-agent receives before writing a single line of code.

**Why this directory exists:** dark code is a context failure, not a model failure. An agent given thin context optimizes for "working" over "comprehensible." An agent given a compiled context package produces code consistent with prior reasoning.

**Who writes here:** `context-compiler` skill — before any build starts. One package per build, named `{build-id}.md`.

**Who reads here:** the sub-agent receiving the build task, and later any auditor asking "what did this agent know when it wrote this code?"

**Liability value:** proves new agents were informed by prior reasoning. Changes were not made blind.

See `ryven-brain/doctrine/ryven-build-certification.md` for the full framework.

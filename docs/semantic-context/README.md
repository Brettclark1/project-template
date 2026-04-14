# docs/semantic-context/

**Purpose:** Home for semantic rules — rules of engagement encoded with embedded meaning (intent + boundary + failure mode), not literal instructions. Agents reason from meaning, so rules handle novel situations correctly instead of failing at edge cases the author never anticipated.

**Who writes here:** `semantic-rules` skill — whenever a new constraint, boundary, or rule of engagement is established during a build.

**Who reads here:** every sub-agent at the start of a build, via `context-compiler`. Semantic rules are injected as read-only context before any code is written.

**File format:** one rule per file, `{rule-name}.md`, with this structure:

```
RULE: [name]
WHY: [the problem this prevents]
BOUNDARY: [where it applies / where it explicitly does not]
FAILURE MODE: [what breaking this looks like in production]
```

See `ryven-brain/doctrine/ryven-build-certification.md` for the full framework.

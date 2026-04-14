---
name: living-systems-check
description: Validate a project's Living Systems Layer configuration against the three-tier framework (Micro, Standard, Full Genetic). Checks living-systems.yml exists and parses, all declared agents have directories, and @ryven/enforcement-runtime is installed. Read-only — reports all issues at once. Run during scaffold phase before the first conductor session.
---

# Skill: Living Systems Check

## When to Use
During scaffold phase (after project structure is created, before build begins) or manually at any time to validate that a project's Living Systems Layer is correctly configured. Run this before the first conductor session on any new project.

## What It Does
Validates four requirements for Living Systems Layer compliance:

1. **Config exists** — `living-systems.yml` is present in the project root
2. **Config is valid** — parses and passes all 17 validation rules from the enforcement runtime (version, default_policy, agents, rules, hooks, circuit breakers, fatigue)
3. **Agent directories exist** — every agent declared in the config has a corresponding directory under `agents/`
4. **Runtime dependency installed** — `@ryven/enforcement-runtime` is listed in `package.json` dependencies

## How to Run

In Claude Code at the project root:

```
Run the living-systems-check skill
```

Or invoke directly:

```
Validate this project's Living Systems Layer configuration
```

## Procedure

1. Check if `living-systems.yml` exists in the current working directory.

2. If it exists, read the file and parse it using `@ryven/enforcement-runtime`'s config parser. If the runtime is not installed, fall back to reading the YAML and checking structure manually:
   - `version` field present and is `"1.0"`
   - `default_policy` is `"DENY"` or `"ASK"` (never `"ALLOW"`)
   - `agents` array is non-empty with unique IDs
   - Each agent has `permission_tier` 1-5, no tool in both allowed and denied lists
   - `rules.deny`, `rules.ask`, `rules.allow` are arrays with unique rule IDs
   - `hooks` sections are arrays
   - `circuit_breakers` reference existing agents
   - `fatigue` has positive integers for `max_asks_per_agent` and `window_seconds`

3. For each agent in the config, check that a directory exists at `agents/{agent_id}/`.

4. Read `package.json` and check that `@ryven/enforcement-runtime` appears in `dependencies` or `devDependencies`.

## Output Format

Print a pass/fail report:

```
=== Living Systems Check ===

  ✅ living-systems.yml exists
  ✅ Config valid (2 agents, 3 deny rules, 1 ask rule, default: DENY)
  ❌ Missing agent directory: agents/security-auditor/
  ✅ @ryven/enforcement-runtime in package.json (file:../ryven-enforcement-runtime)

Result: 3/4 checks passed — 1 issue to fix
```

For validation failures, list every error:

```
  ❌ Config validation failed:
     - default_policy: Fail-open is a security defect. Must be "DENY" or "ASK"
     - agents[1].id: Duplicate agent id: "research-agent"
     - circuit_breakers[0].agent_id: References nonexistent agent: "ghost"
```

## Rules
- This skill only reads — it never modifies files
- Report ALL issues at once (don't stop at the first failure)
- If `living-systems.yml` doesn't exist, skip checks 2-3 and report the missing file
- If `package.json` doesn't exist, report it and skip the dependency check

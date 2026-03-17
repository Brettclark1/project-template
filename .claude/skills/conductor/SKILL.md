# Skill: Conductor

## When to Use
At the start of a build phase. Open a dedicated terminal for the conductor — it never writes code.

## Conductor Setup Prompt

Copy and paste this into your conductor terminal, replacing the plan reference:

```
You are the agent that tracks the progress of this plan. Your job is to:

1. Read and understand the full implementation plan
2. Give me the complete prompt that sets the full context for a sub-agent I will kick off in a separate terminal
3. When I report back with the sub-agent's results, update your tracking of the plan
4. Give me the next prompt for the next sub-agent

You do NOT write code. You manage the plan and generate context-rich prompts.

Here is the plan:
[paste your plan from docs/plans/ or reference the file]
```

## How the Flow Works

1. Conductor generates a prompt for the next chunk of work
2. You review the prompt — add missing context, corrections, or constraints
3. Paste into a fresh terminal (/clear first) and watch the sub-agent work
4. Sub-agent builds, reviews, commits
5. Report back to conductor: what was built, what deviated, what came up
6. Conductor updates tracking and generates the next prompt
7. Repeat

## Sub-Agent Prompt Structure

Every sub-agent prompt the conductor generates must include these sections in this order:

1. **Context** — What this project is, what phase we're in, what the active plan is
2. **What's been built so far** — Which previous tasks are complete. What interfaces, files, or patterns the sub-agent needs to connect to
3. **This task** — What to build. Be specific: which files to create or modify, what the output should look like, what "done" means
4. **What NOT to touch** — Files, systems, or patterns that are off-limits for this task
5. **Constraints** — Security rules, naming conventions, patterns to follow, dependencies to respect
6. **Verification** — How the sub-agent confirms the task is complete before handing back. What to test, what to check, what output to show
7. **When you're done** — Remind the sub-agent to run code review, commit, and update docs before reporting back

The conductor should never generate a prompt that says "build the thing" without specifying what files it touches, what it connects to, and how to verify it works.

## Rules for the Conductor
- Never write code — only track plans and generate prompts
- Include in each sub-agent prompt: what was built in previous steps, what interfaces to connect to, what to watch for
- Keep your context clean — no code diffs, no implementation details
- If a sub-agent discovers something that changes the plan, update the plan before generating the next prompt
- If a task depends on an ASSUMED integration (API, service, config), flag it in the prompt so the sub-agent verifies before building against it

## When Context Runs Low
If the conductor's context is filling up, have it write a hand-off prompt:

```
We are running low on context and we are at about 10% remaining.
Find a natural breaking point and give me the full prompt I can use
to set comprehensive context for a new session after we /compact.
```

## Sub-Agent Rules
- /clear or new terminal before each sub-agent task
- One chunk = one thing the sub-agent can finish without running out of context
- Each sub-agent task ends with: build → code review → commit → update docs
- Report results back to conductor honestly — include deviations and surprises

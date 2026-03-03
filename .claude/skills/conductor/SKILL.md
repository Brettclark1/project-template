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

## Rules for the Conductor
- Never write code — only track plans and generate prompts
- Include in each sub-agent prompt: what was built in previous steps, what interfaces to connect to, what to watch for
- Keep your context clean — no code diffs, no implementation details
- If a sub-agent discovers something that changes the plan, update the plan before generating the next prompt

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

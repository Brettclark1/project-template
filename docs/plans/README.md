# Implementation Plans

Active plans live here. Completed plans go in `completed/`.

## Naming Convention
```
YYYY-MM-DD-feature-name-design.md   (what we're building)
YYYY-MM-DD-feature-name-plan.md     (how we'll implement it)
```

## Workflow
1. Plan is created during brainstorming/planning phase
2. Conductor terminal reads the plan and generates sub-agent prompts
3. Sub-agents execute chunks of the plan
4. After each chunk: build → review → commit → update docs
5. When fully complete, move both files to `completed/`

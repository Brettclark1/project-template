# Implementation Plans

Active plans live here. Completed plans go in `completed/`.

## Creating a Plan
Use the template at `docs/templates/plan-template.md`. Copy it, rename it, fill it in. The conductor reads these to generate sub-agent prompts, so the structured task format matters.

## Naming Convention
```
YYYY-MM-DD-feature-name-plan.md
```

## Workflow
1. Plan is created during brainstorming/planning phase
2. Conductor terminal reads the plan and generates sub-agent prompts
3. Sub-agents execute chunks of the plan
4. After each chunk: build → review → commit → update docs
5. When fully complete, move the plan to `completed/`

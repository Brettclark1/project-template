# Skill: Update Docs

## When to Use
After code review passes and the commit is done. Docs come last because they describe the thing you just committed — not the thing you plan to build.

## Instructions

Review what was just built and update the relevant documentation:

1. **`docs/features/CHANGELOG.md`**
   - Add a high-level entry for what changed
   - Keep it scannable — one line per change, grouped by date
   - Not a commit log — describe the capability, not the code

2. **`docs/features/` files**
   - If a new capability was added, create or update the relevant feature doc
   - If existing behavior changed, update the description to match current reality

3. **`docs/tech/architecture.md`**
   - Only update if the system architecture actually changed (new service, new data flow, new integration)
   - Don't update for routine feature work

4. **`docs/tech/adrs/`**
   - If a significant technical decision was made during this task, create a new ADR
   - Use the template in `ADR-000-template.md`

5. **`CLAUDE.md`**
   - Only update if a new project convention was established
   - Keep it short — signpost to docs, don't inline content

6. **Plan tracking**
   - If a plan step is fully complete, note it in the plan file
   - If the entire plan is done, move it to `docs/plans/completed/`

## What NOT to Do
- Don't rewrite docs that are still accurate
- Don't add implementation details that the AI can discover from code
- Don't create docs for things that haven't been built yet

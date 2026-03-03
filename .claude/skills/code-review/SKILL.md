# Skill: Code Review

## When to Use
Run this after every sub-agent task, before committing. The AI will skip this step on its own — you need to explicitly ask for it.

## Instructions

Review the code changes just made and check:

1. **Does the code do what the plan said it should?**
   - Compare against the active plan in `docs/plans/`
   - Flag anything that was skipped or done differently

2. **Integration point issues**
   - Does new code connect correctly to existing code?
   - Are there function calls to endpoints that don't exist yet?
   - Are there references to props, variables, or fields that were renamed?

3. **Obvious bugs and missing error handling**
   - Null/undefined checks where data could be missing
   - API calls without error handling
   - Database queries that don't account for empty results

4. **Consistency**
   - Naming conventions match the rest of the codebase
   - Patterns match what's established (don't introduce a new way of doing something that already has a convention)
   - No dead code or commented-out blocks left behind

5. **Security**
   - No hardcoded secrets, tokens, or credentials
   - No sensitive data logged to console
   - Input validation on user-facing endpoints

## Output
Provide a summary: what looks good, what needs fixing. If everything passes, say so clearly. Don't invent issues that aren't there.

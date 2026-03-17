# Skill: Session Handoff

## When to Use
When ending a session that will continue later — whether you're running low on context, switching focus, or stopping for the day. The handoff captures everything the next session needs to pick up cleanly without re-reading the entire codebase.

## Instructions

Write a handoff document in `docs/handoffs/` named `SESSION-HANDOFF-YYYY-MM-DD.md` (add `-evening`, `-2`, etc. if multiple in one day).

The handoff must include:

1. **What was accomplished this session**
   - Tasks completed (reference the plan if one is active)
   - Files created or modified
   - Commits made

2. **Current state**
   - What's working right now
   - What's partially built (and how far along)
   - What's broken or blocked

3. **What comes next**
   - The next task from the plan (or what should happen if no plan exists)
   - Any decisions that need to be made before proceeding
   - Anything that was discovered during the session that changes the approach

4. **Watch out for**
   - Gotchas the next session should know about
   - Things that were tried and didn't work (so the next session doesn't repeat them)
   - ASSUMED items that still need verification
   - Dependencies between what was built and what's coming next

5. **Key files to read**
   - List the 3-5 most important files the next session should look at first
   - Include active plan file if applicable

## Format
Keep it scannable. Bullet points, not paragraphs. The next session needs to get oriented in 60 seconds, not read an essay.

## What NOT to Do
- Don't paste code into the handoff — point to files
- Don't summarize the entire project history — just this session and what's next
- Don't leave out blockers or unknowns — the next session can't fix what it doesn't know about

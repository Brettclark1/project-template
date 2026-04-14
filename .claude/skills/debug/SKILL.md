---
name: debug
description: Systematic debugging protocol — reproduce, isolate, read before writing, one hypothesis at a time, verify the fix. Stops shotgun-guessing and forces structured diagnosis before any code changes. This is the project-template's lightweight debug skill, not the gstack investigate skill.
---

# Skill: Debug

## When to Use
When something isn't working and the fix isn't obvious. Stops the AI from shotgun-guessing and forces a structured diagnosis before any code changes.

## Instructions

Before changing ANY code, work through this sequence:

1. **Reproduce** — What exactly is failing? Get the specific error message, status code, or unexpected behavior. Don't guess — run the thing and show the output.

2. **Isolate** — Where in the chain does it break?
   - Is the request leaving the client correctly?
   - Is it reaching the server/worker?
   - Is the function receiving the right input?
   - Is the output wrong, or is the output right but being handled wrong downstream?
   - Check one layer at a time. Don't jump to conclusions.

3. **Read before writing** — Open the relevant file and read the actual code around the failure point. Don't rely on memory of what the code "should" look like. Context windows lie — the file on disk is the truth.

4. **One hypothesis at a time** — State what you think is wrong and why. Make one change to test that hypothesis. Verify. If it didn't fix it, revert and try the next hypothesis. Never stack multiple guesses into one change.

5. **Verify the fix** — Run the thing again. Show the output. Confirm the error is gone AND nothing else broke.

## Rules
- **Never make speculative bulk changes.** "Let me refactor this while I'm in here" during a debug session is how new bugs get introduced.
- **Never say "this should fix it" without running it.** Should means didn't verify.
- **If the third hypothesis fails, zoom out.** You're probably looking at the wrong part of the system. Re-read the error. Trace the data flow from the beginning.
- **Log before you change.** If you can't tell what a function is receiving or returning, add a temporary log statement first. Diagnose with data, not intuition.

## Output
State what was wrong, what fixed it, and why it was happening. One sentence each. If the root cause suggests a broader issue (pattern that could fail elsewhere), flag it.

---
name: conductor
description: Run the conductor/sub-agent workflow pattern for parallel development. One conductor terminal tracks the plan and generates context-rich prompts; fresh sub-agent terminals execute focused tasks with no prior context. Includes evaluator integration and circuit breaker rules. Use at the start of any build phase.
---

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
6. **Conductor launches evaluator** (see Evaluator Integration below)
7. Conductor updates tracking and generates the next prompt
8. Repeat

## Sub-Agent Prompt Structure

Every sub-agent prompt the conductor generates must include these sections in this order:

1. **Context** — What this project is, what phase we're in, what the active plan is
2. **What's been built so far** — Which previous tasks are complete. What interfaces, files, or patterns the sub-agent needs to connect to
3. **This task** — What to build. Be specific: which files to create or modify, what the output should look like, what "done" means
4. **What NOT to touch** — Files, systems, or patterns that are off-limits for this task
5. **Constraints** — Security rules, naming conventions, patterns to follow, dependencies to respect
6. **Verification** — How the sub-agent confirms the task is complete before handing back. What to test, what to check, what output to show
7. **When you're done** — Remind the sub-agent to: (a) tell you exactly where to go in the UI and what to click to verify the feature works, (b) run code review, (c) commit, (d) update docs. Testing comes before review — you verify it works before the AI reviews its own code

The conductor should never generate a prompt that says "build the thing" without specifying what files it touches, what it connects to, and how to verify it works.

**Every sub-agent prompt must also cite the Required Sub-Agent Skills section below.** The prompt should explicitly name `test-driven-development`, `systematic-debugging`, and `verification-before-completion` as mandatory for the sub-agent's workflow, not optional suggestions. If the prompt doesn't tell the sub-agent which skills are required, the sub-agent will skip them.

## Required Sub-Agent Skills (Non-Negotiable)

These three skills are load-bearing for every task the conductor dispatches. They are **not optional**. The conductor's sub-agent prompt MUST explicitly require each one in the Constraints section, and the conductor MUST verify each was followed before accepting the sub-agent's "done" report.

### 1. `test-driven-development` — Every feature and bugfix, no exceptions

**Rule:** When a sub-agent implements any feature or bugfix, it MUST follow the `test-driven-development` skill. Write the test first, watch it fail, write minimal code to pass. **No production code without a failing test first.**

**Why:** Tests written after implementation describe what the code does, not what it should do. Tests written first define the contract. Every feature Ryven ships needs that contract to be explicit, not retrofitted.

**How the conductor enforces it:**
- Sub-agent prompt's Constraints section names `test-driven-development` as mandatory
- Sub-agent's "done" report must show the failing test it wrote first (git history or test output)
- If the sub-agent reports done without a test that was written before the implementation, the conductor rejects the completion and sends it back

**Applies to:** every new feature, every bugfix, every refactor that changes observable behavior. Does NOT apply to: pure documentation changes, config-only deployments, one-line typo fixes that don't alter logic.

### 2. `systematic-debugging` — Every bug or test failure, before any fix

**Rule:** When a sub-agent encounters a bug or test failure during implementation, it MUST use the `systematic-debugging` skill before attempting any fix. **No fixes without root cause investigation.**

**Why:** AI agents default to pattern-matching on error messages and applying the first fix that makes the error go away. That's how "fixed" bugs reappear two tasks later with a different symptom. Systematic debugging forces the four-phase Iron Law: investigate → analyze → hypothesize → implement. No fixes skip investigation.

**How the conductor enforces it:**
- Sub-agent prompt's Constraints section names `systematic-debugging` as mandatory for any failure encountered during the task
- When the sub-agent reports a fix, the conductor's acceptance question is: *"What was the root cause, and how do you know?"* A fix that passed the test but can't answer that question is rejected and sent back for root-cause analysis
- If the sub-agent changes files without first writing a diagnosis of the failure, the conductor halts the task

**This works with the Circuit Breaker.** The Circuit Breaker trips on two consecutive failures on the same task. The `systematic-debugging` skill exists to prevent that second failure — if the first fix attempt came from real root-cause analysis, the second attempt is almost never needed.

### 3. `verification-before-completion` — Every completion claim, from sub-agent AND conductor

**Rule:** Before any sub-agent or the conductor claims work is complete, they MUST follow the `verification-before-completion` skill. Run the verification command, read the output, then claim the result. **No completion claims without fresh evidence.**

**Why:** "Done" is the single most dangerous word in an AI-agent workflow. Sub-agents (and conductors) will claim completion based on the last thing they did working in isolation, not based on the system actually being in a known-good state. A sub-agent that built 4 files, ran tests once at step 2, then finished step 4 will confidently report "all tests pass" even though the last two file changes were never tested together. Verification-before-completion forces a fresh run right before the claim.

**How the conductor enforces it:**
- Sub-agent prompt's "When you're done" section names `verification-before-completion` as mandatory
- Sub-agent's "done" report must include the command run, the command output, and the timestamp. "Tests passed earlier" is not a completion claim — it's a guess
- The conductor itself follows the same rule before accepting a sub-agent's report AND before claiming a task is complete to Brett. The conductor re-runs verification from its own terminal context if the stakes warrant it (deploy, merge, client-facing deliverable)

**Applies to:** typecheck, lint, unit tests, integration tests, and whatever domain-specific verification exists for the task (curl the endpoint, open the UI, inspect the DB row, etc.). Evidence before assertions, always.

### How These Three Skills Compose

- `test-driven-development` makes the verification command exist in the first place
- `systematic-debugging` keeps the verification command honest when it fails
- `verification-before-completion` forces a fresh run of the verification command right before the completion claim

Together they close the "I think it works" / "I'll test it later" / "It worked last time" gap that defines most AI-agent failure modes. Any conductor task that skips any of the three has already failed — the conductor just doesn't know it yet.

## Flow Mode

If the user says **"flow mode"**, **"keep going"**, or **"don't stop"**, proceed through tasks without asking for approval between each one. **Still** run `code-review`, `security-review`, `legibility-pass`, and `verification-before-completion` on every task. **Still** commit per task. But do not stop to ask permission between tasks.

The user will say **"slow down"** or **"stop"** when they want to resume one-at-a-time approval.

**Flow mode does NOT turn off:**
- Required Sub-Agent Skills above (TDD, systematic-debugging, verification-before-completion) — these are non-negotiable regardless of mode
- `code-review`, `security-review`, and `legibility-pass` after each task
- Per-task commits (never batch commits across tasks)
- The Circuit Breaker (two-strikes rule still applies)
- Red Flags (drift, scope creep, unauthorized file modification still halt the flow)

**Flow mode DOES turn off:**
- Between-task approval requests ("Ready for task 3?")
- Plan confirmation between tasks
- Status-check pauses
- The conductor's default "should I proceed?" behavior after evaluator reports

**How to recognize flow mode is active:** the user explicitly said one of the trigger phrases in a recent message. The conductor does NOT assume flow mode from context — it only enters flow mode on an explicit phrase, and exits as soon as the user says "slow down" or "stop" (or any task produces a critical finding from code-review / security-review / legibility-pass / verification that the conductor judges warrants Brett's attention, regardless of mode).

## Mandatory Certification Gate — `legibility-pass`

After `security-review` passes and before `commit`, the conductor MUST run `legibility-pass` on every build task. This is a **pipeline gate**, not an optional step. The conductor cannot mark a build complete without it.

**Rule:** The building sub-agent (not a fresh one) produces a comprehension artifact while its context is still fully loaded, saved to `docs/comprehension/{module-name}.md` with `TYPE: GENERATED-AT-BUILD`. The artifact contains the plain-English summary, what the module touches, what it deliberately does not touch, load-bearing assumptions, rejected alternatives, agent flags, and the comprehension gate verdict.

**Why:** Dark code is AI-generated code that passes tests but nobody can explain. Ryven ships a Build Certification Package proving every module's reasoning was captured at build time, not reconstructed under audit pressure later. `legibility-pass` is the keystone skill that produces that evidence. A timestamped artifact written by the agent that did the work is liability-grade proof; a reconstruction from git history is not.

**How the conductor enforces it:**
- Sub-agent prompt's "When you're done" section names `legibility-pass` as mandatory, to run after `security-review` and before `commit`
- Sub-agent's "done" report must include the artifact path and the COMPREHENSION GATE verdict (`yes` / `no` / `needs-review`)
- If the COMPREHENSION GATE is `no` or `needs-review`, the conductor flags the module for founder review before proceeding to the next task
- If the sub-agent reports done without the artifact path, the conductor rejects the report and sends it back to generate the artifact before context is cleared
- The conductor NEVER runs `legibility-pass` from a fresh sub-agent terminal — that would produce a `RECONSTRUCTED` artifact (the job of `dark-audit`), not a `GENERATED-AT-BUILD` artifact

**Full framework:** see `ryven-brain/doctrine/ryven-build-certification.md`. The other four certification skills (`dark-audit`, `semantic-rules`, `context-compiler`, `liability-review`) are not pipeline gates — they run on their own triggers (quarterly, per-new-rule, per-build-start, per-delivery).

## Rules for the Conductor
- Never write code — only track plans and generate prompts
- Include in each sub-agent prompt: what was built in previous steps, what interfaces to connect to, what to watch for
- Keep your context clean — no code diffs, no implementation details
- If a sub-agent discovers something that changes the plan, update the plan before generating the next prompt
- If a task depends on an ASSUMED integration (API, service, config), flag it in the prompt so the sub-agent verifies before building against it

## Red Flags — When to Hit Escape
Watch the sub-agent while it works. Most of the time, let it run. But stop it immediately if you see:

- **Asks a question then keeps going** — The AI poses a question, assumes an answer, and builds on that assumption. If the assumption is wrong, everything after it is wrong. Stop it, answer the question, then say "continue."
- **Drifts from the task** — Building something adjacent to what you asked for, or over-engineering a simple feature. If it's adding a notification system when you asked for a button, redirect.
- **Skips the code review** — It will do this almost every time if you don't explicitly ask. The code review skill exists for a reason.
- **Writes implementation code before a failing test exists** — Violates `test-driven-development`. If the sub-agent is editing `src/` files before it has a test in `tests/` that fails against the current behavior, stop it. Send it back to write the test first.
- **Jumps straight to a fix after a failure** — Violates `systematic-debugging`. If the sub-agent sees an error and immediately proposes a code change without first writing a diagnosis (what broke, where, why, and how you know), stop it. Root cause before fix, always.
- **Claims completion without running verification** — Violates `verification-before-completion`. If the sub-agent reports "done" without showing fresh output from the verification command, stop accepting the report. Send it back to run verification and paste the real output.
- **Commits without generating a comprehension artifact** — Violates the `legibility-pass` certification gate. If the sub-agent's "done" report does not include a `docs/comprehension/{module-name}.md` path with a COMPREHENSION GATE verdict, stop accepting the report. Send it back to produce the artifact before context is cleared — once the building agent's context is gone, the artifact can only be reconstructed by `dark-audit`, which is lower fidelity.
- **Starts refactoring during a fix** — "Let me clean this up while I'm in here" during a debug session is how new bugs get born. One thing at a time.
- **Modifies files it wasn't told to touch** — Especially config files, auth, or database schemas. If the task didn't list it, the sub-agent shouldn't be in it.
- **Generates placeholder/mock data when real data is available** — If an MCP connection exists, the AI should use it instead of guessing schemas or fabricating test data.

Stopping the AI costs 30 seconds. Letting it build three files in the wrong direction costs cleanup time. If you stop it and it was actually fine, just say "continue" — it picks up right where it left off.

<!-- ADD YOUR OWN: What patterns have burned you? What does the AI do that -->
<!-- you've learned to watch for in your specific workflow? Put them here. -->

## Circuit Breaker — Repeated Player Failures

If a player agent fails on the same task twice in a row — same file, same error pattern — the conductor MUST stop retrying and escalate to human review. A third automatic attempt is never allowed.

### How It Works

After every player failure, the conductor records:
- Which file(s) the failure occurred in
- The error message or pattern (compiler error, test failure, runtime exception, etc.)
- The approach the player took

On the second consecutive failure for the same task, the conductor compares:
1. **Same file?** — Did both failures touch the same file(s)?
2. **Same error pattern?** — Is the error message substantively the same (not just identical — same root cause)?

If both conditions match, the circuit breaker trips.

### When the Circuit Breaker Trips

The conductor MUST:

1. **Stop immediately.** Do not generate a third player prompt for this task.

2. **Log the failure pattern** in this format:

   ```
   --- CIRCUIT BREAKER TRIPPED ---
   Task: [task description]
   File(s): [file paths involved]

   Attempt 1:
     Approach: [what the player tried]
     Error: [error message or pattern]

   Attempt 2:
     Approach: [what the player tried]
     Error: [error message or pattern]

   Pattern: [one-line description of why these are the same failure]
   Status: ESCALATED TO HUMAN REVIEW
   ---
   ```

3. **Surface the log to Brett** and wait for direction. Do not proceed to the next task until Brett has reviewed the failure and provided guidance.

### Why This Exists

AI agents that fail the same way twice will fail the same way a third time — or worse, they'll "fix" the surface error while introducing a deeper problem. The third attempt costs tokens and time while producing work that needs to be reverted. Two strikes is the limit.

### What Counts as "Same Error Pattern"

- Same compiler/type error on the same line → same pattern
- Same test failing with the same assertion → same pattern
- Different error message but same root cause (e.g., missing import both times) → same pattern
- Different file but same logical mistake (e.g., wrong API call signature in two places) → same pattern
- Completely different error after a genuine fix attempt → NOT same pattern (reset the counter)

### What the Conductor Should Do Instead of Retrying

When escalating, suggest one of these to Brett:
- "The player may need additional context about [specific thing] — should I add it to the prompt?"
- "This might be a design issue rather than an implementation issue — should we revisit the plan?"
- "The player is fighting [specific constraint] — should we change the approach?"

The conductor's job is to diagnose WHY the player is failing, not to keep throwing the player at the same wall.

## When Context Runs Low
If the conductor's context is filling up, have it write a hand-off prompt:

```
We are running low on context and we are at about 10% remaining.
Find a natural breaking point and give me the full prompt I can use
to set comprehensive context for a new session after we /compact.
```

## Evaluator Integration

After every sub-agent completes a task, the conductor launches a separate evaluator sub-agent in its own terminal with fresh context. The evaluator has NO knowledge of the generator's process — it only sees output artifacts and the task spec.

**MODE: SHADOW** — The evaluator runs on every task but does NOT gate results. The conductor proceeds regardless of the verdict. The evaluation score and verdict are logged and displayed so Brett can compare against his own review. Brett will say when to flip to live gating.

### Evaluator Launch Procedure

When a sub-agent reports done, the conductor:

1. **Identifies the task metadata:**
   - `task_id` — short kebab-case identifier for the task (e.g., `implement-phone-routing`)
   - `task_type` — one of `task_type_code` (default), `task_type_prd`, `task_type_docs`
   - `output_paths` — list of files the sub-agent created or modified
   - `round_number` — starts at 1

2. **Reads `docs/eval-criteria.yml`** and merges any task-type overrides.

3. **Fills in the evaluator prompt template** from `docs/prompts/evaluator.md`:

   ```
   You are a QA evaluator. You did not produce this work. You have no context about
   the reasoning or process behind it. Your job is to score the output against the
   criteria below and provide specific, actionable feedback.

   Do not be generous. Do not infer intent. Score what is present in the output, not
   what the author probably meant.

   ## Task Spec
   [paste the original task prompt the sub-agent received]

   ## Task Type
   [task_type_code | task_type_prd | task_type_docs]

   ## Evaluation Criteria
   [paste contents of docs/eval-criteria.yml with any task-type overrides merged]

   ## Output to Evaluate
   [list all file paths the sub-agent produced, one per line]

   ## Round
   1 of 3

   ## Instructions
   1. Read every output file listed above.
   2. Score each criterion 0-10 with a one-sentence justification.
   3. List specific failures found. Reference file:line where possible.
   4. Compute the weighted average using the weights from the criteria config.
   5. Verdict:
      - PASS — weighted average >= pass_threshold AND no critical security failures.
      - FAIL — weighted average < pass_threshold OR critical security failure found.
      - ESCALATE — blocking issue outside criteria scope.
   6. If FAIL: state exactly what needs to change, not how to change it.
   7. If round 2+: explicitly note which prior failures are now resolved and which remain.

   ## Output Format
   Write your evaluation as JSON to: docs/evaluations/[task_id]-round-1.json
   ```

4. **Dispatches to a fresh evaluator terminal** (/clear first, same as any sub-agent).

5. **Reads the evaluation JSON** from `docs/evaluations/{task_id}-round-{N}.json`.

### Iteration Logic

**On PASS:**
- Log the score: `Evaluator: {task_id} — PASS ({weighted_average}/10)`
- In shadow mode: proceed to next task.
- In live mode: proceed to next task.

**On FAIL:**
- Log the score: `Evaluator: {task_id} — FAIL ({weighted_average}/10, round {N}/3)`
- In shadow mode: log the failures, proceed to next task anyway.
- In live mode (when enabled):
  1. Feed the failures list back to the original sub-agent as specific feedback:
     ```
     The evaluator scored your output {weighted_average}/10 (threshold: {pass_threshold}).
     Fix these specific failures before proceeding:

     [paste failures array from evaluation JSON, one per line]

     Do not change anything else. Only address these specific failures.
     When done, report what you changed.
     ```
  2. Increment round_number and re-run the evaluator.
  3. Max 3 rounds. If still failing after round 3, escalate.

**On ESCALATE:**
- Log: `Evaluator: {task_id} — ESCALATE (round {N})`
- Surface the full evaluation JSON to Brett and stop. The evaluator flagged something outside criteria scope that needs human judgment.

**After 3 failed rounds (live mode only):**
- Surface the full evaluation JSON (all 3 rounds) to Brett and stop. This is a design problem, not a QA problem.

### Shadow Mode Output

In shadow mode, after each evaluation the conductor includes this note in its output:

```
--- Evaluator Report (Shadow Mode) ---
Task: {task_id}
Score: {weighted_average}/10
Verdict: {verdict}
Failures: {count}
Report: docs/evaluations/{task_id}-round-1.json
---
```

This lets Brett compare the evaluator's judgment against his own review without blocking the workflow.

### Evaluator Rules

- The evaluator is ALWAYS a separate sub-agent — never the same terminal as the generator
- The evaluator does NOT fix the work — it only scores and provides feedback
- The evaluator has NO context from the generator's session — fresh terminal, fresh context
- Evaluation reports go to `docs/evaluations/` (gitignored, local-only)
- The conductor never modifies evaluation reports — they are append-only artifacts

## Sub-Agent Rules
- /clear or new terminal before each sub-agent task
- One chunk = one thing the sub-agent can finish without running out of context
- **Required skills (non-negotiable, see Required Sub-Agent Skills section above):**
  - `test-driven-development` — write the failing test first, always
  - `systematic-debugging` — root cause before fix, always
  - `verification-before-completion` — fresh verification output before any "done" claim, always
- Each sub-agent task ends with: **failing test first** → build (minimal code to pass) → **systematic debugging if any failure** → **verification-before-completion run** → code review → security review → **legibility-pass (certification gate)** → commit → update docs
- Report results back to conductor honestly — include deviations and surprises, and include the literal output of the verification command
- After sub-agent reports done, conductor always launches evaluator before moving to next task
- In flow mode, the conductor proceeds to the next task automatically after the evaluator passes; in normal mode, the conductor waits for Brett's approval between tasks

## Session Start Checklist (Conductor reads this at every /build)

Before dispatching any task, the conductor MUST display this checklist to Brett:
cd ~/Dev/project-template && git add .claude/skills/conductor/SKILL.md && git commit -m "Add session start checklist to conductor — context-compiler, liability-review, semantic-rules triggers" && git push
cat >> ~/Dev/project-template/.claude/skills/conductor/SKILL.md << 'EOF'

## Session Start Checklist (Conductor reads this at every /build)

Before dispatching any task, the conductor MUST display this checklist to Brett:--- SESSION START ---

Extending or modifying existing modules?
YES → run context-compiler first before any task is dispatched
NO  → skip context-compiler, proceed to first task
Will this session produce a client deliverable?
YES → run liability-review before delivery (not at end of session — at delivery)
NO  → skip liability-review
Any new constraints, integrations, or boundaries emerging this session?
YES → run semantic-rules after the task that introduced them
NO  → skip semantic-rules



Do not proceed to the first task until this checklist is displayed and Brett has read it.

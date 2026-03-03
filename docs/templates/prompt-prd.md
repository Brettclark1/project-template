# Prompt Template: Generate a PRD

Use this prompt at the start of any new project. Paste into ChatGPT or Claude with your project context.

**Key rule:** Stop the LLM if it tries to do technical implementation. This step is about the problem and the value.

---

```
I want to create a Product Requirements Document (PRD) for [PRODUCT NAME]. We've been discussing this product and I want to formalize what we know. Think like a product owner — focus on the problems we're solving and the value we're creating, not the technical implementation.

Structure the document as follows:

1. PROBLEM STATEMENT
- What problem does this product solve?
- What are users doing today without it? (manual processes, blind spots, etc.)
- What pain points are they experiencing?
- Why is this problem worth solving now?

2. USER PERSONAS & USE CASES
- Who will use this product?
- For each user type:
  - What decisions are they trying to make?
  - What questions are they trying to answer?
  - What actions will they take based on the product's output?
- Describe 2-3 specific scenarios where someone would use this product

3. VALUE PROPOSITION
- What outcomes will users achieve?
- How will their work or decisions improve?
- How does success get measured? (time saved, errors prevented, revenue generated, etc.)

4. USER EXPERIENCE & WORKFLOWS
For each key user journey, describe:
- What the user wants to accomplish
- What they see on each screen
- What actions they can take
- What happens next
- What the end result looks like
Include at least one concrete example scenario written as a narrative.

5. CORE CAPABILITIES (The "What" not the "How")
What must this product be able to do? Frame as user capabilities:
- "Users can..."
- "Users receive..."
- NOT: "System will query APIs and store data in database"

6. SUCCESS CRITERIA
- How will we know this product is working?
- What does "good" look like for version 1.0?
- What feedback would we want to hear from early users?

7. OUT OF SCOPE (for MVP)
- What are we explicitly NOT building in version 1?
- What features can wait until we validate the core value?

8. OPEN QUESTIONS & DECISIONS NEEDED
- What don't we know yet?
- What assumptions are we making?
- Where do we need stakeholder feedback before building?

Write this as if you're pitching the product to someone who will use it, not someone who will build it. Focus on outcomes and user value.
```

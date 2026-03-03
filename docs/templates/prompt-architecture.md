# Prompt Template: Design the Architecture

Use after you have a validated PRD. Paste into your coding tool with the PRD attached/referenced.

**Key rule:** Replace `[current timeframe]` with the actual date. Tell it to research current best practices — not 12-month-old recommendations.

---

```
I'm attaching a Product Requirements Document (PRD) for a project I'm about to build. I need your help designing the technical architecture. Think like a senior solutions architect — recommend the right tools for the job, explain your reasoning, and flag trade-offs.

I want you to produce an architecture.md document structured as follows:

1. PROJECT SUMMARY
- One paragraph restating what we're building (from the PRD) in technical terms
- Who the users are and roughly what scale we're designing for (MVP)

2. TECH STACK RECOMMENDATIONS
For each layer of the stack, recommend a specific technology and explain WHY:
- Frontend framework
- Styling approach
- Language
- Backend / API layer
- Database
- Authentication
- File storage (if needed)
- Hosting / deployment

For each recommendation:
- State the choice
- Give 2-3 reasons why it fits THIS project specifically
- Note any alternatives worth considering and why you didn't pick them
- Flag if there's a decision I need to make

3. SYSTEM ARCHITECTURE
- Describe how the pieces fit together at a high level
- What calls what? What data flows where?
- Include a simple diagram description (mermaid or text-based)

4. DATA MODEL (high level)
- What are the core entities?
- How do they relate to each other?
- What's the access pattern? (who reads what, who writes what)
- Don't write SQL — just describe the shape of the data

5. THIRD-PARTY INTEGRATIONS & APIs
- What external services does this project need?
- For each: what it does, rough cost expectations, rate limits or constraints

6. SECURITY & ACCESS CONTROL
- Auth approach
- Role-based access
- Data isolation (multi-tenant considerations if applicable)
- API key management strategy

7. MVP SCOPE vs. FUTURE ARCHITECTURE
- Simplest version of the architecture that delivers the MVP
- What would need to change at scale?
- What decisions are hard to reverse later?

8. OPEN TECHNICAL QUESTIONS
- What do you need to know from me before finalizing?
- Multiple valid approaches and your recommendation?
- Assumptions you're making?

Important guidelines:
- Do online research to verify current best practices and pricing. We are in [current timeframe] — make sure recommendations reflect what's available TODAY.
- Optimize for SPEED TO MVP, not perfection
- Prefer managed services over self-hosted
- Prefer boring, well-documented technology over cutting-edge
- Be specific — don't say "use a database," say "use Supabase (Postgres) because..."
```

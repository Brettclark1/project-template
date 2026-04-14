---
name: feature-impact
description: Assess the blast radius of a proposed change before implementation — what existing features does it touch, what shared data does it affect, what edge cases does it create, what integrations does it depend on. Produces an impact report with risks and mitigation recommendations. Use before building any new feature.
---

# Skill: Feature Impact Analysis

## When to Use
Before building any new feature. Checks how the new thing will intersect with everything that already exists, catching edge cases early.

## Instructions

Before starting implementation, analyze the proposed feature against the existing product:

1. **Read the current feature docs**
   - Review all files in `docs/features/` to understand what exists today
   - Review `docs/tech/architecture.md` for system-level context

2. **Identify intersection points**
   - What existing features does this new feature touch?
   - What shared data does it read or write?
   - What UI components or pages does it affect?
   - What API endpoints does it call or modify?

3. **Surface edge cases**
   - What happens if the new feature and an existing feature try to modify the same data?
   - Are there state transitions that could conflict?
   - Are there user workflows where the new feature changes existing behavior?
   - Are there permission or access control implications?

4. **Check integration dependencies**
   - Does this feature depend on third-party services that other features also use?
   - Could rate limits or API quotas become an issue?
   - Are there shared caches or queues that could be affected?

5. **Flag risks and recommendations**
   - List any conflicts or risks found
   - Recommend mitigation steps
   - Note if the implementation plan needs to be adjusted

## Output
A brief impact report: what intersects, what's at risk, what to watch for during the build. If the feature is isolated with no impacts, say so clearly.

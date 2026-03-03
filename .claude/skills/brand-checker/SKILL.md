# Skill: Brand Checker

## When to Use
Before finishing any UI change or front-end feature. Verifies visual consistency against the project's brand guide.

## Setup
This skill requires a `brand.md` file in the project root. Generate one during the planning phase using the brand identity prompt from your planning process.

## Instructions

Before marking any UI work as complete, check against `brand.md`:

1. **Colors** — Are all colors from the approved palette? No hardcoded hex values that aren't in the guide?
2. **Typography** — Correct font families, sizes, and weights per the guide?
3. **Spacing** — Following the base spacing unit and layout conventions?
4. **Components** — Do cards, buttons, inputs match the established patterns?
5. **Tone** — Does any copy match the brand voice described in the guide?

## What NOT to Do
- Don't redesign existing components to "improve" them unless asked
- Don't introduce new colors, fonts, or patterns without updating `brand.md`
- Don't skip this check just because the change is "small"

## If No brand.md Exists
Flag it. Ask if we should create one before proceeding with UI work.

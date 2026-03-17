# Skill: Security Review

## When to Use
Before any deployment. After adding a new API integration, secret, or external service connection. When a sub-agent task involved credentials, environment variables, or third-party code. This is separate from code review — code review checks correctness, this checks exposure.

## Instructions

Scan the project for security issues across these categories:

1. **Credential exposure**
   - Search all files for hardcoded API keys, tokens, passwords, or connection strings
   - Check git history: `git log --all -p -S "key" -S "token" -S "secret" -S "password"` (adjust search terms per project)
   - Verify `.env` is in `.gitignore`
   - Verify `.env.example` has empty values only — no real keys, not even expired ones
   - Check console.log / print statements for anything that could leak secrets in logs

2. **Credential copies**
   - Count how many places each secret exists (every copy is an attack surface)
   - Secrets should live in exactly one place: `.env` locally, cloud env vars in production
   - If a secret is passed between services, verify it's passed at runtime, not stored in multiple configs

3. **Third-party code**
   - Any new dependency added this session? Check what it does
   - For Claude Code skills from external sources: review full source for outbound data calls, hardcoded URLs, obfuscated code, credential access
   - If source can't be fully reviewed, flag it — build custom instead

4. **API and endpoint security**
   - Are new endpoints authenticated where they should be?
   - Is input validated? (no raw user input passed to queries, file paths, or shell commands)
   - Are error messages generic to the client? (don't leak stack traces, file paths, or internal state)
   - Are CORS settings intentional, not just permissive by default?

5. **Infrastructure**
   - Are secrets in the right place for the deployment target? (Wrangler secrets for Workers, env vars for other platforms)
   - Is least-privilege applied? (each service/agent only has the credentials it needs)
   - Are unguessable identifiers used where needed? (report URLs, session tokens, etc.)

## Output
List findings by severity: CRITICAL (fix before deploy), WARNING (fix soon), INFO (note for later). If everything passes, say so clearly — don't invent issues.

## What NOT to Do
- Don't skip this because "it's just an internal tool" — internal tools get exposed
- Don't assume a secret is safe because it's in an environment variable — verify which env and who can read it
- Don't approve third-party code you haven't fully read

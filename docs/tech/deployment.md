# Deployment — [PROJECT NAME]

<!-- Fill this in BEFORE writing feature code. Deploy a hello world first. -->
<!-- Infrastructure problems are cheap to find early and expensive to find late. -->

## Deployment Target
<!-- e.g., Cloudflare Workers, Vercel, Railway, Supabase Edge Functions -->

## Deploy Command
<!-- e.g., npx wrangler deploy, vercel --prod, railway up -->

## Environments

| Environment | URL | Status |
|---|---|---|
| Production | <!-- e.g., https://app.example.com --> | Not deployed / Live |
| Staging | <!-- if applicable --> | |

## Environment Variables Checklist
<!-- Every secret that must be set in the deployment target before it works. -->
<!-- Cross-reference with .env.example — they should match. -->

| Variable | Set in prod? | Set in staging? | Notes |
|---|---|---|---|
| <!-- e.g., DATABASE_URL --> | No | N/A | <!-- where to get it --> |

## DNS / Domain
<!-- Domain registrar, DNS provider, any CNAME/A records needed -->
<!-- Status: not configured / configured / verified -->

## Hello World Verification
<!-- After first deploy, what do you check to confirm it's working? -->
<!-- e.g., visit /api/health, check deployment logs, curl the endpoint -->

- [ ] First deploy completed
- [ ] App loads in browser
- [ ] Environment variables confirmed working
- [ ] Custom domain configured (if applicable)

## Deployment Notes
<!-- Platform-specific gotchas, build settings, region config, etc. -->
<!-- e.g., "Wrangler needs compatibility_date set in wrangler.toml" -->
<!-- e.g., "Vercel auto-detects Next.js but needs OUTPUT_DIRECTORY override" -->

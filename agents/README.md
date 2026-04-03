# Living Systems Layer — Autonomous Agents

This directory contains the autonomous agents that comprise the Living Systems Layer for this project.

## Reference

All agents are specified per the **Living Systems Layer PRD v3.0** (`doctrine/living-systems-layer-prd-v3.md`). Agent declarations, permission levels, and drift surface assignments are defined in `living-systems.yml` at the project root.

## Directory Structure

| Directory | Purpose |
|-----------|---------|
| `research/` | Research agents that monitor drift surfaces and ingest external data. Write to quarantine buffer only (Permission Level 0-1). |
| `security/` | Security audit agents. Autonomous posture audits on defined schedules (Permission Level 4). |
| `compliance/` | Compliance monitoring agents. Track regulatory and policy drift (Permission Level 0). |
| `code-audit/` | Code audit agents. Dependency checks, vulnerability scanning, schema validation (Permission Level 0). |
| `annealing/` | Self-healing / annealing agents. Reconcile new knowledge against existing behavior (Permission Level 3). Tier 3 only. |

## Rules

- Every drift surface must have a named agent (PRD Section 2).
- Ingestion and execution are never the same agent (PRD Section 2).
- Permission levels are declared in `living-systems.yml`, not in agent prompts (PRD Section 6).
- An agent cannot self-elevate. Elevation requires config change and redeployment.
- No agent ever reads, logs, displays, or transmits credentials. Agents reference secret identifiers only.

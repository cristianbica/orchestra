# Pattern: Verification-First Workflow

## What it is

Orchestra makes verification route- and surface-specific. Builder runs every
applicable focused, aggregate, static, build/package, manual/negative, and
route-specific category rather than treating one passing check as sufficient.
Validator checks the evidence, reruns relevant checks, and uses a negative or
edge-case probe when appropriate.

## How it shows up here

- `.ai/MEMORY.md` records verified commands and durable verification conventions.
- `.ai/playbooks/` holds complex verification procedures that need inputs,
  approvals, setup, cleanup, or evidence rules.
- `scripts/verify-control-plane.sh` runs focused semantic checks for routing,
  roles, operations, playbooks, and adapter capability contracts.
- `scripts/verify.sh` runs the focused verifier plus aggregate installer and
  wrapper smoke checks.
- Native runtime checks supplement the required semantic checks when the
  corresponding CLI is available; unavailable checks are reported explicitly.

## Why it matters

This keeps documentation honest: commands are only recorded once they are known to work in a given repo.

## See also

- [Memory](../../MEMORY.md) - Verified commands and conventions
- [workflows.md](../features/workflows.md) - Verification steps in each workflow

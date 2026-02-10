# Pattern: Discovery-First Planning

## What it is

The **discovery-first pattern** requires planning to always start with a quick scan of existing code, docs, and patterns before drafting the plan.

This prevents plans that ignore context, propose contradictions, or duplicate existing solutions.

## Why it matters

Missing discovery leads to:
- ❌ Plans that ignore existing patterns or conventions
- ❌ Scope expansion (only after implementation, realizing design conflicts)
- ❌ Duplicate effort (rebuilding something that already exists)
- ❌ Doc/memory misalignment (decisions made without knowing what's documented)

With discovery:
- ✓ Plans align with existing patterns
- ✓ Trade-offs are visible upfront
- ✓ Scope is realistic (aware of constraints)
- ✓ Verification strategy is informed (knows what exists to test against)

## The discovery checklist

Architect MUST verify before drafting:
- [ ] I understood the goal and success criteria
- [ ] I checked `.ai/docs/overview.md` for app context
- [ ] I read `.ai/docs/features/README.md` and relevant feature pages
- [ ] I read `.ai/docs/patterns/README.md` and affected pattern pages
- [ ] I reviewed existing plans in `.ai/plans/` for similar work
- [ ] I know how to verify success (tests/commands to run)
- [ ] I identified which `.ai/docs/**` pages will need updating

See [src/ai/agents/architect.md](../../src/ai/agents/architect.md#discovery_checklist) for the full checklist.

## Example: Discovering constraints

Scenario: "Implement bulk user import feature"

Discovery findings:
- ✓ Features already exist: single-user import, batch operations
- ✓ Pattern found: `/user/import/` follows REST conventions
- ✓ Constraint found: docs say "no long-running requests without jobs queue"
- ✓ Test found: existing import tests use factories + rollbacks

**Result**: Plan proposes async job queue + test against existing factories.

Without discovery:
- ❌ Plan might propose synchronous import (violates constraint)
- ❌ Tests might not use existing patterns
- ❌ Plan might ignore existing feature interactions

## See also

- [src/ai/agents/architect.md](../../src/ai/agents/architect.md) — Full Architect role with discovery rules
- [src/ai/agents/guides/context-management.md](../../src/ai/agents/guides/context-management.md) — Efficient discovery & assembly

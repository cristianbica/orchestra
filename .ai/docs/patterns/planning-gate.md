# Pattern: Route-Specific Planning Gates

## Rule

Planning and approval come from the selected row in the authoritative
[routing matrix](../../../src/ai/agents/guides/routing.md). There is no generic
"non-trivial work" gate: a route with no plan must not receive an invented one.

| Route | Artifact and approval |
| --- | --- |
| `direct answer` | No plan or approval |
| `change` | Inline or file plan; explicit approval before implementation |
| `document` | No plan or route approval |
| `investigate` | Report, not an implementation plan; no route approval |
| `trivial-change` | No plan or route approval |
| `guided` | Inherits the selected target route exactly |
| `bootstrap`, `refresh-context` | Inline per-run preview; explicit approval before commands or broad writes |
| `create-overlays`, `define-playbook` | Approved change-style plan unless eligible for `trivial-change` |
| `run-playbook` | No plan for non-mutating runs; approved `change` plan for non-trivial product/app mutation |

## Plan artifacts

A required plan is either one in-chat message titled `Plan (inline)` or
`.ai/plans/<YYYY-MM-DD>-<INDEX>-<slug>.md`. Prefer inline plans at no more than
30 non-empty lines; use a file for larger, persistent, or explicitly requested
plans.

Approval must explicitly identify the exact plan. A previous plan, investigation
report, guided step confirmation, operation preview approval, playbook invocation
approval, or destructive-command approval does not authorize a different gate.

## Promotion

When planless eligibility stops holding, stop before out-of-route writes and
select the route that covers the new work. The new route starts its normal intake
and gates; earlier scope confirmation is evidence, not substitute approval.

Forger follows the same rule. On a plan-required route it performs discovery,
creates the plan, and stops for approval before entering its implementation
phase. On a planless route it records that no plan is required.

## See also

- [plan template](../../../src/ai/templates/plan.template.md)
- [Planner role](../../../src/ai/agents/planner.md)
- [workflow routes](../features/workflows.md)
- [operations](../features/operations.md)

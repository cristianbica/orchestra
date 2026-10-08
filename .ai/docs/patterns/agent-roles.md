# Pattern: Agent Roles and Isolation

## Canonical ownership

The [routing matrix](../../../src/ai/agents/guides/routing.md) assigns execution,
validation, allowed writes, and terminal handling per route. Roles implement
that contract; they do not impose a universal plan gate.

| Role | Ownership | Hard boundary |
| --- | --- | --- |
| `Conductor` | Select one route, coordinate gates and handoffs, map review status to terminal state | Never implements product/app code |
| `Planner` | Read-only investigation and route-owned inline or `.ai/plans/**` plans/reports | Never implements product/app code |
| `Builder` | Approved implementation or an explicitly planless narrow mutation | Never bypasses a required plan or expands scope |
| `Validator` | Review plus owned `.ai/docs/**` and `.ai/MEMORY.md` hygiene | Never implements product/app code |
| `Forger` | Explicitly selected single-agent execution with visible role phases | Never delegates or mixes permissions across phases |

Operations may assign Validator additional context/archive writes. That ownership
comes from the selected routing row and operation, not from general permission
to edit product files.

## Route-sensitive handoffs

For `change`, Planner creates the plan, the user explicitly approves it, Builder
implements, Validator reviews, and Conductor closes the route. Builder must run
all applicable verification categories and report skips.

Planless routes preserve separation without inventing a plan:

- `document`: Validator owns the target-scoped doc update and validation.
- `investigate`: Planner returns a report and leaves product/source unchanged.
- `trivial-change`: Builder edits the requested target; Validator reviews scope
  plus the actual diff.
- `guided`: every owner and gate comes from its one selected target route.

Forger may assume Planner, Builder, and Validator ownership only in the matching
phase. It creates a plan and stops for approval when the target route requires
one; explicit selection never relaxes the gate.

## See also

- [canonical roles](../../../src/ai/agents/)
- [planning gate](planning-gate.md)
- [workflow routes](../features/workflows.md)

# Feature: Workflow Routes

## Canonical contract

The authoritative route, gate, ownership, and completion contract is
[the routing matrix](../../../src/ai/agents/guides/routing.md). Workflow files add
procedure but do not add or remove matrix gates.

Conductor selects exactly one route before execution. A direct answer needs no
specialist or file change and stays with Conductor.

## Workflow set

| Workflow | Artifact and approval | Execution and validation |
| --- | --- | --- |
| `change` | Inline or file plan; explicit approval before implementation | Planner plans, Builder implements, Validator reviews |
| `document` | No plan or route approval | Validator updates named `.ai/docs/**` targets from evidence |
| `investigate` | Report, not an implementation plan; no route approval | Planner performs read-only investigation and reports findings |
| `trivial-change` | No plan or route approval | Builder applies the narrow correction; Validator checks scope plus diff |
| `guided` | Inherits the selected target route exactly | Changes cadence only; target ownership and validation remain intact |

`change` covers non-trivial product/app features, bugs, and refactors. If a
planless route stops fitting, work stops before out-of-route writes and is
promoted through the newly selected route's normal gates.

## Evidence and verification

- Planner may write only route-owned inline or `.ai/plans/**` plan/report
  artifacts; product/source investigation remains read-only.
- Builder runs every verification category applicable to the touched surface.
  One passing category does not replace another, and unavailable checks are
  reported explicitly.
- Validator reviews an approved plan when the route requires one. For planless
  work, requested scope plus diff and route-specific evidence are sufficient.
- Validator may update `.ai/docs/**` and `.ai/MEMORY.md`, but never product/app
  code.

## Shortcuts

Command and legacy aliases classify intent only. They must match the boundary
grammar in the routing guide and then rejoin normal intake, gates, ownership,
validation, and terminal handling. Incidental substrings are not shortcuts.

## See also

- [change workflow](../../../src/ai/workflows/change.md)
- [document workflow](../../../src/ai/workflows/document.md)
- [investigate workflow](../../../src/ai/workflows/investigate.md)
- [trivial-change workflow](../../../src/ai/workflows/trivial-change.md)
- [guided wrapper](../../../src/ai/workflows/guided.md)
- [operations](operations.md)

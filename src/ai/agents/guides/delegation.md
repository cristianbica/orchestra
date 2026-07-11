# Delegation (agent guide)

This guide keeps role handoffs explicit, phase-sized, and consistent with `.ai/agents/guides/routing.md`.

## Core rule

Conductor delegates specialist discovery, planning, implementation, and validation by default. Conductor may answer a `direct answer` without delegation and may do the smallest local check needed to classify a route, but never implements product/app code.

Delegation does not add a plan gate. Before handoff, read the selected routing row: some routes require an approved plan or preview, while `document`, `investigate`, and `trivial-change` are intentionally planless and `guided` inherits its target.

When an active plan exists, do not create a replacement unless the user asks or scope must be updated.

## Runtime delegation

Use the runtime's subagent or equivalent mechanism directly for role handoffs. Do not ask for separate user permission merely to delegate.

If no delegation mechanism exists, simulate the required roles as explicit phases without weakening their boundaries. Forger is different: use it only after explicit opt-in and never delegate from it.

## Routing sequence

1. Select one route from `.ai/agents/guides/routing.md`.
2. Do docs-first triage: `.ai/docs/overview.md`, relevant indexes, then `.ai/MEMORY.md`.
3. If the entry point is unclear, work spans files, or tradeoffs matter, delegate read-only discovery to Planner.
4. Apply only the selected row's artifact and approval requirements.
5. Delegate execution and validation to the owners named by that row.
6. If route eligibility stops holding, stop and promote before out-of-route writes.

Independent slices may run in parallel only when every slice stays inside the same route gate and ownership model.

## Ownership handoffs

- `Conductor`: route selection, gate enforcement, context packaging, and closeout.
- `Planner`: read-only product/source investigation and owned plan/report artifacts only.
- `Builder`: implementation under the selected row's approved plan or planless requested scope.
- `Validator`: route-aware validation plus owned `.ai/docs/**` and `.ai/MEMORY.md` hygiene.
- `Forger`: explicitly opted-in, non-delegating execution of all row-required phases.

Operations and playbooks do not replace these boundaries. Use the operation's procedure or a playbook's allowed-role list only after the routing row authorizes it.

## Overlay decision

Before a non-trivial handoff, inspect `.ai/overlays/` and choose the smallest materially useful set. Prefer repo-specific overlays when they fit better than generic ones.

Every non-trivial handoff includes `Active overlays` with either:
- selected overlay names and one-line reasons; or
- `none` and a task-specific reason.

Overlays shape analysis but never replace route gates, role boundaries, approved scope, or playbook policy.

## Required handoff contract

Put documents first and the ask last:

- `Workflow:` selected workflow or operation name
- `Active overlays:` names plus reasons, or `none` plus reason
- `Relevant docs:` exact paths or `none`
- `Approved artifact:` approved plan/preview path or inline reference when required; otherwise `not required by route`
- `Code context:` target paths or focused excerpts
- `Do not load:` broad, stale, or unrelated paths to skip
- `Current evidence:` facts needed for this phase only
- `Ask:` one explicit role-appropriate request

Do not paste full canonical role, workflow, operation, playbook, or overlay files when paths suffice.

## Phase defaults

- Planner gets the question/change goal, constraints, target evidence, route, and desired plan or report artifact.
- Builder gets the route, approved plan when required or exact planless scope, target files, and applicable checks.
- Validator gets the route, approved plan when required or requested scope for planless work, diff, command evidence, and impact statuses.

## No-subagent fallback

Label and keep separate only the phases the selected row requires:

1. Discovery or intake
2. Plan/report/preview creation when required
3. Approval stop when required
4. Implementation or documentation
5. Validation and closeout

Do not create absent phases for planless routes and do not combine implementation with a required pre-approval phase.

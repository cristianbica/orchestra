# Operation: define-playbook

Create or update a reusable repo-local procedure. Follow the `define-playbook` row in `.ai/agents/guides/routing.md` and the schema in `.ai/templates/playbook.template.md`.

## Intake and scope

Conductor records the purpose, slug, concrete use/exclusion cases, invocation mode, allowed roles, required inputs, side effects, data sensitivity, approval gates, child playbooks, cleanup, failure handling, terminal states, and evidence requirements.

Allowed writes are limited to the named `.ai/playbooks/<slug>.md` and its required playbook index. Sensitive data, production or production-derived access, secrets, paid services, external systems, destructive steps, and non-trivial local artifacts must have explicit, scoped approval requirements.

## Route and ownership

1. Conductor selects this operation and records materially relevant overlays.
2. Planner reads the template, playbook index, declared children, repo evidence, and relevant existing procedures. Planner writes a scoped `change`-style plan artifact that names commands, side effects, approval boundaries, and verification.
3. The user explicitly approves the plan before playbook writes.
4. Builder creates or updates only the named playbook and required index. Mark claims `verified` only with command-backed evidence; otherwise use `provisional`.
5. Validator checks plan adherence, schema, lifecycle status, invocation policy, role compatibility, inputs, child declarations, risk, approvals, cleanup, failure handling, terminal states, evidence, references, and impact statuses.

An exact wording-only correction to an existing playbook with no change to procedure, commands, policy, risk, inputs, roles, children, approvals, cleanup, evidence, or lifecycle must instead use `trivial-change`. Validator then reviews requested scope plus diff without a plan. If triviality is uncertain, stop and return to the planned route. Forger may assume phases only under the routing contract's explicit opt-in and boundaries.

## Design requirements

- `auto` is limited to bounded, low-risk, read-only work inside an already authorized route.
- `suggest-first` waits for approval of the exact playbook run.
- `explicit-only` requires the user to name or explicitly approve the exact playbook.
- `May call` lists every possible child by slug, or `none`; child policies and gates remain independent.
- `draft` and `deprecated` are not executable. `provisional` requires explicit per-run acknowledgement; `verified` still obeys all other gates.
- Cleanup and rollback claims name the resources/artifacts that make them possible.

## Completion

Builder reports the approved plan or trivial scope, playbook/index diff, checks, provisional claims, and explicit skips. Validator returns review status `approve` or `needs changes`.

Conductor alone records `complete`, `blocked`, or `failed` as defined by the routing matrix. Report doc impact and memory impact; do not widen writes solely to resolve those impacts.

## Checklist

- [ ] Purpose, use cases, and exclusions are concrete.
- [ ] Invocation mode, allowed roles, inputs, and runtime questions are scoped.
- [ ] Side effects, data sensitivity, approvals, and enclosing-route requirements are explicit.
- [ ] `May call` is complete and child references resolve.
- [ ] Setup, ordered execution, cleanup, failure handling, and allowed terminal states are defined.
- [ ] Evidence is concrete and lifecycle/verification status is honest.

# Operation: run-playbook

Execute a named reusable procedure under the `run-playbook` row in `.ai/agents/guides/routing.md`. A playbook supplies procedure, never route authority.

## Intake

Conductor records the playbook slug, scope, environment, known inputs, selected executor facts, enclosing route/plan when present, and requested artifact destinations. Ask only missing runtime questions declared by the playbook.

Invocation approval, risk approval, and `change` plan approval are distinct. Approval to run a playbook never substitutes for explicit approval of an enclosing `change` plan.

## Recursive preflight

Before any playbook command, write, external call, or process start, Conductor traverses the root and all transitively declared `May call` children and records one preflight result. Fail closed on missing/duplicate slugs, undeclared calls, or dependency cycles. For every node verify:

1. **Status:** `draft` and `deprecated` do not run; `provisional` requires explicit per-run acknowledgement; `verified` remains subject to all gates.
2. **Children:** every possible child is listed in `May call`, resolves under `.ai/playbooks/`, and passes this same preflight. `none` permits no child call.
3. **Role:** the assigned executor is in `Allowed roles` and may perform every step under the enclosing route. Forger requires explicit user selection and never delegates.
4. **Inputs:** all required inputs are known, scoped, and valid before the node runs; optional inputs do not silently widen scope.
5. **Approvals:** enforce each node's invocation mode and step approvals. `auto` is valid only for bounded low-risk read-only work already authorized by the enclosing route; `suggest-first` and `explicit-only` require their declared approval. Production, production-derived data, secrets, paid services, external systems, destructive steps, and non-trivial local artifacts require separate scoped per-run approval.
6. **Risk and writes:** declared side effects, data sensitivity, commands, external systems, artifact paths, and process behavior fit both the playbook and enclosing route.
7. **Cleanup and failure:** cleanup owners/actions and failure behavior are executable and bounded. Rollback is claimed only when named snapshots, manifests, transactions, or equivalent recovery artifacts will exist.
8. **Terminal contract:** allowed outcomes use `complete`, `blocked`, `failed`, and `rolled back` only, and the playbook defines evidence required for each outcome it allows.

If any node can make a non-trivial product/app mutation, Conductor requires an enclosing `change` route whose explicitly approved plan names the exact root playbook, mutation scope, writes, and verification. Without it, stop before execution and route to `change`. A currently authorized route may invoke only playbook work that fits its own mutation and write boundaries.

## Execution

1. Preserve the approved preflight record and approvals as run evidence.
2. Conductor routes each node to a role allowed by both the playbook and selected route. A role handoff does not transfer permissions or satisfy approval.
3. The executor runs steps in order and stops at any unmet gate, scope change, undeclared child, or stale preflight fact.
4. Before invoking a child, confirm it was preflighted and re-check time-sensitive approvals/inputs; do not discover and authorize a new child during execution.
5. Record commands, outputs, writes, artifacts, side effects, process IDs, child results, and evidence as they occur.
6. Run declared cleanup on success and failure. Stop only run-owned processes and delete only run-owned temporary artifacts; verify cleanup and record residuals.

## Validation and terminal state

Validator checks the full preflight graph, approvals, enclosing plan when required, execution evidence, child outcomes, cleanup, and claimed terminal outcome. Validator returns review status `approve` or `needs changes`; Validator does not set the route terminal state.

Conductor records:

- `complete` only when all required nodes and cleanup succeed and Validator approves;
- `blocked` when approval, input, plan, role, environment, or remediable evidence is missing;
- `failed` when execution is closed unsuccessfully after required failure cleanup;
- `rolled back` only when declared recovery ran and its restoration evidence verifies.

The final report includes the preflight record, all distinct approvals, per-node results, command/output summary, writes/artifacts, cleanup and rollback status, Validator review status, Conductor terminal state, and residual risk.

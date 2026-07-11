# Feature: Operations

## What they are

Operations are built-in Orchestra side tasks under `.ai/operations/`. They are
separate from development lifecycle workflows and follow the authoritative
[routing matrix](../../../src/ai/agents/guides/routing.md).

| Operation | Gate and owner |
| --- | --- |
| `bootstrap` | Validator executes only after explicit approval of an inline per-run preview |
| `refresh-context` | Validator executes only after explicit approval of an inline per-run preview |
| `create-overlays` | Builder uses an approved change-style plan unless wording-only work qualifies for `trivial-change` |
| `define-playbook` | Builder uses an approved change-style plan unless wording-only work qualifies for `trivial-change` |
| `run-playbook` | An allowed role executes only after recursive preflight and every applicable approval |

Plans and investigation reports under `.ai/plans/**` are route artifacts, not
built-in operation templates.

## Context operations

`bootstrap` and `refresh-context` require the preview before commands or broad
writes. Before target mutation, the run must create and verify a timestamped
`.ai-archive/<run-id>/` snapshot and manifest, then track commands, writes,
created resources, and processes in a run ledger.

Rollback is limited to run-owned changes: restore snapshotted paths, remove only
recorded creations, and stop only recorded processes. Concurrent or unowned
changes stop automatic rollback. Product/app changes are promoted to `change`.

## Definition operations

`create-overlays` writes one repo-local `.ai/overlays/<slug>.md` plus its required
index. `define-playbook` writes one `.ai/playbooks/<slug>.md` plus its required
index. Neither operation is a framework rollout path.

## Playbook execution

`run-playbook` recursively preflights the root and every declared child before
execution. It verifies lifecycle status, `May call` declarations, cycles,
allowed roles, inputs, approvals, risk and writes, cleanup, failure behavior,
and terminal evidence. Undeclared children and incomplete preflight fail closed.

Invocation approval never substitutes for explicit approval of an enclosing
`change` plan. Any non-trivial product/app mutation requires that approved plan
to name the exact playbook and mutation scope.

## See also

- [operation definitions](../../../src/ai/operations/README.md)
- [playbook contract](../../../src/ai/playbooks/README.md)
- [workflows](workflows.md)
- [playbooks](playbooks.md)

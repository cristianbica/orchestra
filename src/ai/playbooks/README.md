# Playbooks

Playbooks are reusable, repo-local procedures. They describe how to perform known work safely; `.ai/agents/guides/routing.md` remains authoritative for route selection, mutation scope, plan approval, ownership, validation, and terminal handling.

Use playbooks for procedures too detailed for `.ai/MEMORY.md`, such as a UI smoke test, bounded local data preparation, or repo-specific release validation. Start from `.ai/templates/playbook.template.md` and store each playbook as `.ai/playbooks/<slug>.md`.

## Invocation policies

- `auto`: only bounded, low-risk, read-only work inside an already authorized route.
- `suggest-first`: recommend the exact playbook and wait for per-run approval.
- `explicit-only`: run only when the user names or explicitly approves the exact playbook.

Production, production-derived data, secrets, paid services, external systems, destructive steps, and non-trivial local artifacts require explicit scoped approval regardless of mode. Invocation or risk approval never substitutes for required approval of an enclosing `change` plan.

## Lifecycle

- `draft`: incomplete and not executable.
- `provisional`: executable only with explicit per-run acknowledgement of unverified claims.
- `verified`: command-backed at the recorded date; all current route and approval gates still apply.
- `deprecated`: not executable.

Playbooks declare allowed terminal states from `complete`, `blocked`, `failed`, and `rolled back`. Validator returns review status `approve` or `needs changes`; Conductor sets the route terminal state.

## Composition

- `May call` lists every possible direct child slug, or `none`.
- Every child retains its own status, roles, inputs, invocation/step approvals, risk, cleanup, evidence, and terminal contract.
- `run-playbook` recursively preflights the complete declared graph before execution, rejects missing children and cycles, and permits no undeclared child.
- A child handoff does not transfer permissions or satisfy approval. Forger never delegates.

## Required execution contract

Each playbook defines concrete use/exclusion cases, allowed roles, required/optional inputs, runtime questions, commands, side effects, data sensitivity, approval gates, child calls, evidence, cleanup, failure handling, lifecycle status, and terminal evidence. Rollback may be promised only when the procedure creates named recovery artifacts or uses an equivalent verified mechanism.

For any non-trivial product/app mutation, the enclosing `change` plan must name the exact playbook, execution scope, writes, side effects, and verification, and the user must approve that plan before mutation.

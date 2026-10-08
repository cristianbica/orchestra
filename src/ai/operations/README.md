# Operations

Operations are built-in Orchestra side tasks. They are not development workflows.

Use operations for framework maintenance and reusable procedure tasks:
- `bootstrap.md` sets up initial repo context.
- `refresh-context.md` refreshes stale `.ai/docs/**` and `.ai/MEMORY.md`.
- `create-overlays.md` adds or updates overlay guidance.
- `define-playbook.md` creates or updates reusable procedures in `.ai/playbooks/`.
- `run-playbook.md` executes a reusable procedure while enforcing its invocation policy.

Workflows in `.ai/workflows/` remain limited to development lifecycle control: change, investigate, document, trivial-change, and guided. Plans in `.ai/plans/` are approval and execution artifacts created during work, not built-in task templates.

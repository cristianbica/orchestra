# Feature: Operations

## What it is

Operations are built-in Orchestra side tasks stored in `.ai/operations/`. They are separate from development lifecycle workflows.

## Built-in operations

| Operation | Purpose |
| --- | --- |
| `bootstrap` | Establish initial `.ai/docs/**` and `.ai/MEMORY.md` context. |
| `refresh-context` | Refresh stale context after major repo or framework changes. |
| `create-overlays` | Add or update overlay guidance. |
| `define-playbook` | Create or update reusable procedures. |
| `run-playbook` | Execute a playbook while enforcing its invocation policy. |

Plans in `.ai/plans/` are approval/execution artifacts created during work. They are not built-in operation templates.

## See also

- [src/ai/operations/README.md](../../../src/ai/operations/README.md)
- [workflows.md](workflows.md)
- [playbooks.md](playbooks.md)

# Feature: Playbooks

## What it is

Playbooks are reusable, repo-local procedures stored in `.ai/playbooks/`. They capture operational knowledge that is too complex for `.ai/MEMORY.md`, such as UI smoke testing, issue-context fetching, data preparation, or repo-specific validation.

## How they fit

- Workflows decide why work is happening and which gates apply.
- Operations cover Orchestra side tasks such as defining or running playbooks.
- Roles decide who plans, implements, or validates.
- Playbooks describe how to run a known reusable procedure.
- Overlays remain supporting context.

Workflows and operations may compose multiple playbooks, and a user may directly run one playbook through the `run-playbook` operation.

## Invocation policy

Each playbook declares one mode:

- `auto` - low-risk, bounded, read-only procedures may run when relevant inside an authorized workflow.
- `suggest-first` - agents may recommend the playbook and wait for approval.
- `explicit-only` - agents may run it only when the user names or explicitly approves that playbook.

Sensitive playbooks, including production or production-derived data, secrets, paid services, external systems, or non-trivial local artifacts, require explicit per-run approval.

## See also

- [src/ai/playbooks/README.md](../../../src/ai/playbooks/README.md)
- [src/ai/templates/playbook.template.md](../../../src/ai/templates/playbook.template.md)
- [src/ai/operations/define-playbook.md](../../../src/ai/operations/define-playbook.md)
- [src/ai/operations/run-playbook.md](../../../src/ai/operations/run-playbook.md)

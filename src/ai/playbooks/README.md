# Playbooks

Playbooks are reusable, repo-local procedures. They describe how to perform a known procedure safely and repeatably, while workflows and operations still control why the work is happening, which role owns it, and which gates apply.

Use playbooks for procedures that are too complex for `.ai/MEMORY.md`, such as running a UI smoke test, preparing a local data snapshot, or validating a repo-specific release path.

## Rules

- Workflow gates and role boundaries still apply.
- A playbook may be recommended or run only according to its invocation policy.
- Stricter approval requirements win when workflow approval and playbook policy overlap.
- Child playbooks must be listed in `May call`, and each child playbook keeps its own invocation policy.
- Production, production-derived data, secrets, paid services, and external systems require explicit per-run approval.

## Invocation policies

- `auto` - agents may run the playbook when relevant inside an authorized workflow. Use only for low-risk, bounded, read-only procedures.
- `suggest-first` - agents may recommend the playbook and wait for approval before running it.
- `explicit-only` - agents may run the playbook only when the user names or explicitly approves that playbook.

## Files

- Add repo playbooks as `.ai/playbooks/<slug>.md`.
- Start from `.ai/templates/playbook.template.md`.
- Keep each playbook concise and operational.

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

The repo-local quality-test playbook automatically selects a substantial public merged Ruby PR with bounded `bundle install` and no external-service requirement, pins every generated workspace to its base, and shows an exact-command plan for approval. It compares a direct clean-room vanilla implementation with bootstrapped Orchestra plan-then-implement runs; one requested Orchestra branch or SHA adds `orchestra-<ref>/`. Codex, Claude Code, OpenCode, and GitHub Copilot CLI use explicit unattended command forms. Bootstrap tokens, time, and cost are excluded; the actual PR is inspected only after generated runs and checks complete.

## See also

- [src/ai/playbooks/README.md](../../../src/ai/playbooks/README.md)
- [src/ai/templates/playbook.template.md](../../../src/ai/templates/playbook.template.md)
- [src/ai/operations/define-playbook.md](../../../src/ai/operations/define-playbook.md)
- [src/ai/operations/run-playbook.md](../../../src/ai/operations/run-playbook.md)

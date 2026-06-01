# Memory (curated)

Max ~200 lines. Prune oldest/least-used when full. One agent updates per session to avoid conflicts.

## Commands (verified)
- Build: `<command>`
- Test: `<command>`
- Lint: `<command>`
- Run: `<command>`

## Conventions
- File naming: ...
- Import style: ...
- Code style: ...
- Built-in overlays: `value`, `system`, `ux`, `data`, `security`, `webdev`, `frontend`, `api`, `integration`, `devops`, `performance`, `testing`, `review`, `payments`, `privacy`, `dx`, `i18n`, `reliability`, `mobile`; workflow gates, operation gates, and approved plans override overlay guidance.
- Context budget: keep always-on context lean; load role/workflow/operation/overlay/docs/plan files on demand; include `Active overlays` and `Do not load` in non-trivial handoffs.
- Prompt compaction: reduce cost through smaller prompts, phased handoffs, and role-specific context.
- Forger is opt-in only and non-delegating; non-trivial work in Forger still requires explicit plan approval.
- Planner plans are read-only, executable, and should name critical files, reusable patterns, and verification steps; Validator should verify adversarially with command-backed evidence.
- Operations live in `.ai/operations/` for built-in side tasks; workflows stay limited to development lifecycle control.
- Playbooks live in `.ai/playbooks/` and describe reusable procedures; `define-playbook` operation creates/updates them, `run-playbook` operation executes them, and stricter playbook approval gates win when policies overlap.

## Invariants (non-negotiable)
- ...

## Repo layout
- Main code: ...
- Tests: ...
- Config: ...

## Business domains
- ... (if applicable; e.g., billing, membership, admin)

## Discovered quirks
- 2026-02-10: Initialized `.ai/` template structure and core roles/workflows.

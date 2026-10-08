# Plan: Unattended plan pre-authorization

Date: 2026-07-11

## Goal

- Let a user explicitly pre-authorize one bounded `change` plan so the normal workflow can continue unattended after planning.

## Non-goals

- Blanket or indefinite approval; changes to planless routes; bootstrap/refresh previews; playbook invocation or risk gates; sensitive or external actions.

## Scope + assumptions

- Pre-authorization is explicit user consent recorded before planning, bound to one `change` request, route, goal, allowed paths/side effects, non-goals, and an expiry.
- It authorizes only implementation of the subsequently produced exact plan if Conductor determines it remains within those bounds; otherwise stop for ordinary exact-plan approval.
- Require an explicit expiry; without trustworthy time support, limit validity to the current conversation/run; invalidate on expiry, new user requirements, route/scope/approach change, or plan revision.
- Never pre-authorize destructive commands, production or production-derived data, secrets/sensitive data, paid services, external-system calls, playbook invocation/risk/step approvals, or any separately required runtime permission.
- Scope is deliberately `change` only; user-facing syntax and maximum expiry are unspecified, so use an explicit, readable request format and a conservative bounded default rather than infer indefinite authorization.

## Steps

1. Add the bounded pre-authorization definition, validity/invalidation rules, and `change`-row approval wording to `src/ai/agents/guides/routing.md`; retain explicit-plan approval as the default.
2. Update `src/ai/workflows/change.md` and `src/ai/agents/{conductor,planner,builder,validator,forger}.md`: capture/recheck the record, retain the plan artifact, permit unattended continuation only when valid, and make Builder/Forger stop on mismatch or expiry.
3. Keep `src/ai/operations/run-playbook.md` and `src/ai/playbooks/README.md` explicit that this exception cannot satisfy invocation, risk, child, or sensitive-action approvals.
4. Extend `src/ai/templates/plan.template.md` with an optional pre-authorization reference/status and required bounds/expiry evidence.
5. Keep adapter policy thin: update only approval wording in `src/tools/{codex,claude-code,copilot,opencode}` entry wrappers that currently say approval is always required; do not encode duplicate contract logic.
6. Mirror canonical `src/ai/**` changes into the local `.ai/**` working copy and mirror wrapper changes into installed root adapter files, preserving unrelated dirty work.
7. Update developer-facing docs: `README.md`, `.ai/docs/features/{workflows,tool-wrappers}.md`, `.ai/docs/patterns/planning-gate.md`; add template-safe guidance only where needed under `src/ai/docs/**`.
8. Strengthen `scripts/verify-control-plane.sh` with required contract phrases and negative checks proving sensitive/playbook approvals remain separate; adjust `scripts/verify.sh` only if its wrapper assertions need updating.

## Verification

- Run `scripts/verify-control-plane.sh`, `scripts/verify.sh`, and `bash -n install.sh`.
- Run targeted searches for stale unconditional approval wording and source/mirror parity.

## Doc impact

- Update: `README.md`, `.ai/docs/features/workflows.md`, `.ai/docs/features/tool-wrappers.md`, `.ai/docs/patterns/planning-gate.md`, and any needed template-safe `src/ai/docs/**` guidance.
- Memory impact: add the durable pre-authorization invariant only after the behavior is verified.

## Rollback (if applicable)

- Revert the scoped canonical, mirror, wrapper, documentation, and verification changes together; no migration or persisted runtime state is introduced.

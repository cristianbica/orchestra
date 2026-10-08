# Workflow: trivial-change

This planless workflow applies an obvious non-behavioral correction. Its authoritative contract is the `trivial-change` row in `.ai/agents/guides/routing.md`.

## Intake (Conductor)

Ask only when unclear:
1. Exact target and requested correction.
2. Confirmation that behavior, policy, commands, schemas, and public contracts do not change.
3. Wording or formatting constraints.

Eligible work is limited to typos, formatting, comments, and narrow wording-only corrections. Size is supporting evidence, not proof of triviality. Any uncertainty about behavior or policy requires promotion to `change`.

## Procedure

1. Conductor records `Active overlays: none` with a local-scope reason unless a material overlay applies.
2. Builder applies only the requested correction. No plan or plan approval is required or requested.
3. Builder reports `trivial-change: <what> in <file>`, the diff, applicable lightweight checks, explicit skips, doc impact, and memory impact.
4. Validator checks the requested scope plus actual diff, confirms no behavior/policy change, and reruns a lightweight check when applicable.
5. Validator returns review status `approve` or `needs changes`. Conductor maps `approve` to `complete`; it maps `needs changes` to `blocked` or promotes to `change` when the diff is not genuinely trivial.

## Done criteria

- The requested scope and diff are both minimal and non-behavioral.
- Applicable checks and skips are reported.
- Validator confirmed eligibility without relying on a commit or pull-request description.

# Workflow: document (target-scoped)

This planless workflow creates or refreshes named `.ai/docs/**` content from current repository evidence. Its authoritative contract is the `document` row in `.ai/agents/guides/routing.md`.

## Intake (Conductor)

Ask only for missing blocking facts:
1. Target doc path(s), or the narrow topic when the path is unknown.
2. Audience and what the reader should be able to understand or do.
3. Source of truth, format constraints, and explicit exclusions.

## Route boundaries

- No plan artifact or plan approval is required.
- Validator owns the documentation work and validation.
- Writes are limited to requested `.ai/docs/**` targets and verified durable facts in `.ai/MEMORY.md`.
- Initial repository setup belongs to `bootstrap`; broad context migration/refresh belongs to `refresh-context`.
- Product/app code or behavior changes require promotion to `change` before mutation.
- Reusable procedure creation belongs to `define-playbook`; descriptive documentation may remain here.

## Procedure

1. Conductor confirms targets, exclusions, source evidence, and overlays for delegated work.
2. Validator inspects only the code, config, commands, and existing docs needed to support the targets.
3. Validator updates the named docs without speculation and preserves existing indexes/links when applicable.
4. Validator runs applicable link, reference, formatting, or documented-command checks and reports explicit skips.
5. Validator records only concise, verified durable facts in `.ai/MEMORY.md`.
6. Conductor reports completion, blockage, or promotion with the target list and evidence.

User feedback may drive another target-scoped adjustment pass without creating a plan. Promote if the requested adjustment crosses route boundaries.

## Done criteria

- Requested docs accurately reflect inspected sources and stay within the named scope.
- Checks, changed targets, source evidence, doc impact, and memory impact are reported.

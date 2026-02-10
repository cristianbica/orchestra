# Humans: how to use this repo’s AI system

This repo treats `.ai/` as the canonical source of truth for agent roles, workflows, plans, and docs.

## Start here
- Read `.ai/README.md`.
- Choose a workflow from `.ai/workflows/`.

## The default loop
- Conductor: picks the smallest workflow and enforces gates.
- Architect: writes a plan when work is non-trivial.
- Builder: implements *only after* the plan is explicitly approved.
- Inspector: reviews the diff against the plan and repo conventions.
- Archivist: updates `.ai/docs/**` and `.ai/MEMORY.md`.

## Plan gate (important)
- Any non-trivial change requires a plan in `.ai/plans/<YYYY-MM-DD>-<slug>.md`.
- Use the template in `.ai/templates/plan.template.md`.
- Do not implement until the plan is explicitly approved.

## Where outputs go
- Plans: `.ai/plans/`
- Feature docs: `.ai/docs/features/`
- Pattern docs: `.ai/docs/patterns/`
- Curated memory (durable facts only): `.ai/MEMORY.md`

## Definition of done (every task)
- Verification: list the exact commands/tests run (or explain why none).
- doc impact: updated | none | deferred
- memory impact: if you learned a durable repo fact (commands, conventions, layout), add 1 short bullet to `.ai/MEMORY.md`.

## Example prompts (copy/paste)
- “Conductor: run the `document` workflow using `.ai/plans/0000-00-01-bootstrap.md`.”
- “Conductor: run the `fix-bug` workflow for <bug description>.”
- “Conductor: run the `implement-feature` workflow for <feature description>.”

## How to give follow-up suggestions
When reviewing an implementation (or giving feedback mid-implementation), paste suggestions as a tight checklist and explicitly say they should be handled under the already-approved plan (same workflow run).

Copy/paste template:
- “Conductor: apply my feedback as adjustments under the already-approved plan (same workflow; no new plan unless scope changes).
  Builder: implement ONLY these items:
  - Tests: <what’s missing>
  - Translations/i18n: <what keys/strings are missing>
  - Docs: <what page to update, if needed>
  Constraints: no new UX/flows/features; no new deps; no data model/security changes.
  Report verification commands run + doc impact.”

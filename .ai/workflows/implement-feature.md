# Workflow: implement-feature

Inputs:
- A feature request and constraints.

Steps:
1. Conductor routes to Architect.
2. Architect writes a plan in `.ai/plans/`.
3. Approval gate: do not implement until the plan is explicitly approved.
4. Builder implements the approved plan.
4a. Feedback handling (user feedback == Inspector findings): if the user provides feedback at any time after plan approval (during implementation or after), treat it like reviewer findings and implement it as an adjustment pass under the already-approved plan within the same workflow run. Create a new plan only for true scope changes.
5. Verification: run the most relevant checks and report what was run.
5. Archivist updates `.ai/docs/` for the feature and any affected patterns.
6. Inspector reviews: plan adherence, correctness, i18n hygiene, and doc impact.
7. Closeout: explicitly state "doc impact" and "memory impact".

Outputs:
- Plan: `.ai/plans/<YYYY-MM-DD>-<slug>.md`
- Updated docs under `.ai/docs/features/` and/or `.ai/docs/patterns/` when needed.

Done criteria:
- Plan exists and was followed.
- Docs updated (or explicitly "doc impact: none" or "doc impact: deferred").
- Durable facts added to `.ai/MEMORY.md` when discovered.

# Workflow: fix-bug

Inputs:
- Bug report (symptoms, expected behavior, reproduction if known).

Steps:
1. Conductor routes to Architect.
2. Architect writes a minimal plan in `.ai/plans/`.
3. Approval gate: do not implement until the plan is explicitly approved.
4. Builder implements the fix.
4a. Feedback handling (user feedback == Inspector findings): if the user provides feedback at any time after plan approval (during implementation or after), treat it like reviewer findings and implement it as an adjustment pass under the already-approved plan within the same workflow run. Create a new plan only for true scope changes.
5. Verification: run the most relevant checks and report what was run.
6. Archivist updates docs only if behavior/UX changed.
7. Inspector reviews and confirms plan adherence + doc impact.
8. Closeout: explicitly state "doc impact" and "memory impact".

Outputs:
- Plan: `.ai/plans/<YYYY-MM-DD>-<slug>.md`
- Updated docs when behavior changes.

Done criteria:
- Bug is fixed within scope.
- Docs updated if behavior changed (or explicitly "doc impact: none" or "doc impact: deferred").

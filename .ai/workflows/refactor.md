# Workflow: refactor

Inputs:
- Refactor goal (what to improve) + explicit constraints (what must not change).

Steps:
1. Conductor routes to Architect.
2. Architect writes plan with "non-goals" and safety checks.
3. Approval gate: do not implement until the plan is explicitly approved.
4. Builder refactors per plan.
5. Verification: run the most relevant checks and report what was run.
6. Archivist updates pattern docs if conventions/structure changed.
7. Inspector reviews: no scope creep; docs updated.
8. Closeout: explicitly state "doc impact" and "memory impact".

Outputs:
- Plan: `.ai/plans/<YYYY-MM-DD>-<slug>.md`
- Updated pattern docs when conventions change.

Done criteria:
- Refactor achieves goal with no unintended behavior changes.
- Pattern docs updated if needed (or explicitly "doc impact: none" or "doc impact: deferred").

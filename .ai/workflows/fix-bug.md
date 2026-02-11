# Workflow: fix-bug

## Intake (Conductor)
Conductor asks:
1) Expected vs actual: What should happen vs what happens now?
2) Repro: Minimal repro steps + environment (branch, flags, user role/tenant) + frequency.
3) Evidence: Error logs/stack trace/screenshot + suspected area (if any).

Optional follow-ups (only if relevant):
- Severity/impact: is this production-blocking, data corruption, security?
- Timeline: needs hotfix vs normal cycle?

Inputs:
- Bug report (symptoms, expected behavior, reproduction if known).

Steps:
1. Conductor routes to Architect.
2. Architect writes a minimal plan in `.ai/plans/`.
3. Approval gate: do not implement until the plan is explicitly approved.
4. Builder implements the fix.
4a. Feedback handling (user feedback == Inspector findings): if the user provides feedback at any time after plan approval (during implementation or after), treat it like reviewer findings and implement it as an adjustment pass under the already-approved plan within the same workflow run. Never create a new plan unless the user explicitly asks.
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

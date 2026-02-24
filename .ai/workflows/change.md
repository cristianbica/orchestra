# Workflow: change (feature | bug | refactor)

## Intake (Conductor)
Conductor asks:
1) Change type + summary: Is this a `feature`, `bug`, or `refactor`, and what is the goal?
2) Outcome criteria: Top acceptance criteria (or expected vs actual + repro for bugs).
3) Constraints: Hard limits (API/schema/UX), compatibility, timeline, and risk notes.

Optional follow-ups (only if relevant):
- Security/data sensitivity, authz, i18n, tenant/role scope.

Inputs:
- A requested change plus constraints and success criteria.

Default overlays:
- Feature planning: `value.md` + `system.md` + `ux.md`
- Refactor: `system.md` + `security.md`
- Bug investigation: `system.md` (add `data.md` for DB issues, `security.md` for sensitive impact)
- Add `data.md` when data model/storage/analytics are in scope.
- Add `security.md` when authn/authz/privacy/risk are in scope.

Precedence:
- Workflow gates and approved plans override overlay guidance.

Steps:
1. Conductor routes to Planner.
2. Planner performs focused discovery and produces a plan artifact (file or inline).
	- Inline plan allowed only if (a) short (<= 25 non-empty lines), or (b) user explicitly requests with: “no plan file” or “don’t write a plan file”.
3. Approval gate: do not implement until the plan artifact is explicitly approved.
4. Builder implements the approved plan.
4a. Feedback handling (user feedback == validator findings): if user feedback arrives after plan approval, treat it as adjustment work under the same approved plan unless scope changes materially.
5. Verification: run the most relevant checks and report what was run.
6. Validator validates plan adherence and gates; updates docs/memory as needed.
7. Closeout: explicitly state `doc impact` and `memory impact`.

Outputs:
- Plan: inline in-chat OR `.ai/plans/<YYYY-MM-DD>-<slug>.md`
- Updated docs when behavior/conventions changed.

Done criteria:
- Plan artifact exists, was explicitly approved, and was followed.
- Change is complete within scope and verified.
- `doc impact` and `memory impact` are explicitly reported.

# Workflow: implement-feature

## Intake (Conductor)
Conductor asks:
1) Feature summary: What are we building (1–2 sentences) + top 3 acceptance criteria?
2) References: Any similar existing flow/file/feature to mirror? (link/path or "none")
3) Constraints: Any hard constraints? (e.g. no schema change, behind a flag, backwards-compatible, timeline)

Optional follow-ups (only if relevant):
- Security/data: authz rules, PII, audit logging requirements?
- UX surface: which screens/routes/APIs are affected?

Inputs:
- A feature request and constraints.

Steps:
1. Conductor routes to Architect.
2. Architect produces a plan artifact (file or inline).
	- Inline plan allowed only if (a) it is short (<= 25 non-empty lines), or (b) the user explicitly requests with: “no plan file” or “don’t write a plan file”.
3. Approval gate: do not implement until the plan artifact is explicitly approved.
4. Builder implements the approved plan.
4a. Feedback handling (user feedback == Inspector findings): if the user provides feedback at any time after plan approval (during implementation or after), treat it like reviewer findings and implement it as an adjustment pass under the already-approved plan within the same workflow run. Never create a new plan unless the user explicitly asks.
5. Verification: run the most relevant checks and report what was run.
5. Archivist updates `.ai/docs/` for the feature and any affected patterns.
6. Inspector reviews: plan adherence, correctness, i18n hygiene, and doc impact.
7. Closeout: explicitly state "doc impact" and "memory impact".

Outputs:
- Plan: inline in-chat OR `.ai/plans/<YYYY-MM-DD>-<slug>.md`
- Updated docs under `.ai/docs/features/` and/or `.ai/docs/patterns/` when needed.

Done criteria:
- Plan artifact exists, was explicitly approved, and was followed.
- Docs updated (or explicitly "doc impact: none" or "doc impact: deferred").
- Durable facts added to `.ai/MEMORY.md` when discovered.

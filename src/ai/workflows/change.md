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

Overlay selection:
- Conductor chooses overlays by following `.ai/agents/guides/delegation.md`, inspecting `.ai/overlays/`, and recording an explicit `Active overlays` decision for delegated work.
- Default to no overlays for tightly local work; add overlays only when they materially change planning, implementation, or validation.

Playbook use:
- Planner may recommend `.ai/playbooks/**` for implementation support or verification when they fit the task.
- Plans that invoke playbooks must name the playbook, required inputs, side effects, invocation policy, and approval requirements.
- Plan approval authorizes a playbook only when the plan names the exact playbook and its execution scope; stricter playbook approval gates still win.

Precedence:
- Workflow gates, role boundaries, approved plan scope, and playbook invocation policy all constrain execution.
- Stricter approval requirements win when constraints overlap.
- Overlays are supporting context only.

Steps:
1. Conductor routes to Planner.
2. Planner performs focused, read-only discovery and produces an executable plan artifact (file or inline).
	- Inline plan is preferred when short (<= 30 non-empty lines), especially in the 20-30 line range.
	- Use `.ai/plans/` plan files when the plan is larger or when a file is explicitly requested.
	- Handoffs name files to load and what not to load instead of pasting full canonical files.
	- The plan must call out the critical files, reusable functions/patterns to reuse first, and the verification steps.
	- For small independent work units, use lean-context: keep the plan minimal but still executable.
3. Approval gate: do not implement until the plan artifact is explicitly approved.
4. Implementation path:
	- Default: Builder implements the approved plan.
	- Opt-in: if user explicitly selected `Forger`, Forger implements in single-agent non-delegating mode.
4a. Feedback handling (user feedback == validator findings): if user feedback arrives after plan approval, treat it as adjustment work under the same approved plan unless scope changes materially.
5. Verification: run the most relevant checks and report what was run. Prefer command-backed checks over code-reading-only confirmation. Use approved playbooks when they are the clearest verification path.
6. Validator validates plan adherence and gates; updates docs/memory as needed.
7. Closeout: explicitly state `doc impact` and `memory impact`.

Outputs:
- Plan: inline in-chat OR `.ai/plans/<YYYY-MM-DD>-<INDEX>-<slug>.md`
- Updated docs when behavior/conventions changed.

Done criteria:
- Plan artifact exists, was explicitly approved, and was followed.
- Change is complete within scope and verified.
- `doc impact` and `memory impact` are explicitly reported.

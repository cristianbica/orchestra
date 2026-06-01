# Operation: run-playbook

## Intake (Conductor)

Conductor asks:
1) Playbook: Which `.ai/playbooks/<slug>.md` should run?
2) Inputs: What required inputs are already known, and which are unknown?
3) Approval: Do you approve this run if the playbook policy requires approval?

Optional follow-ups (only if relevant):
- Scenario/area to test, account/company, environment, time window, artifact destination, or teardown expectations.
- Safety confirmation for production, production-derived data, secrets, paid services, external systems, or mutating steps.

Inputs:
- A playbook slug/name and any required runtime inputs.

Overlay selection:
- Conductor chooses overlays by following `.ai/agents/guides/delegation.md`, inspecting `.ai/overlays/`, and recording an explicit `Active overlays` decision for delegated work.
- Use overlays only when they materially change execution or validation.

Precedence:
- Operation steps, workflow gates when invoked from a workflow, role boundaries, approved plan scope, and playbook invocation policy all constrain execution.
- Stricter approval requirements win when constraints overlap.
- Overlays are supporting context only.

Steps:
1. Conductor resolves the requested playbook under `.ai/playbooks/`.
2. Conductor checks the playbook invocation policy:
   - `auto`: may run only when the current workflow and role already authorize it;
   - `suggest-first`: recommend the playbook and wait for approval;
   - `explicit-only`: require explicit user naming or approval of that exact playbook.
3. If required inputs are missing, ask only the playbook's scoped runtime questions.
4. Route execution to the allowed role:
   - Planner only for read-only, non-mutating evidence gathering;
   - Builder for approved implementation-support steps;
   - Validator for validation/smoke procedures;
   - Forger only when explicitly selected by the user.
5. Execute the steps in order and stop at any unmet approval gate.
6. If the playbook calls another playbook, enforce the child playbook's invocation policy before running it.
7. Report evidence, side effects, artifacts, cleanup status, and failures.

Outputs:
- Playbook execution report in chat or a plan/report file when long.
- Any artifacts created by the playbook, named explicitly.

Done criteria:
- Execution followed the playbook and all approval gates.
- Missing inputs were requested narrowly.
- Evidence and cleanup status are reported.
- Any skipped step explains whether it was policy-blocked, user-blocked, or environment-blocked.

# Workflow: guided (hand-held wrapper)

## Intake (Conductor)
Conductor asks:
1) Target workflow: Which workflow should this guide? (`change` | `investigate` | `document`)
2) Goal + constraints: What should we achieve in this guided run?
3) Step granularity: approve each step, or approve small batches (2-3 steps)?

Optional follow-ups (only if relevant):
- Preferred mode: keep guided throughout, or allow switching to normal mode at any step?

Inputs:
- A target workflow plus user constraints and confirmation style.

Purpose:
- Provide step-by-step, user-steered execution without changing workflow gates.
- Support optional micro inline plans when the user wants tighter control.

Micro-plan format (optional, 3-8 lines):
- Intent
- Action
- Expected result
- Quick check

Steps:
1. Conductor routes to selected target workflow in guided mode.
2. Propose next step (or micro-plan), then wait for user decision.
3. User chooses: `continue` | `revise step` | `switch to normal` | `stop`.
4. Execute only the approved step scope.
5. Run a quick verification for that step and summarize outcome.
6. Repeat until complete or stopped.
7. If scope expands materially, escalate to normal workflow planning and approval.

Precedence:
- Target workflow gates and approved plans override guided suggestions.
- Guided mode never bypasses non-trivial approval requirements.

Outputs:
- Incremental progress updates per approved step.
- Optional inline micro-plans.
- Final closeout with verification, `doc impact`, and `memory impact`.

Done criteria:
- User-directed step sequence is completed or intentionally stopped.
- All executed steps stayed within approved scope.
- Gate behavior remained unchanged.

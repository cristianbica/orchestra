# Workflow: guided (hand-held wrapper)

Guided mode changes interaction cadence only. The target row from `.ai/agents/guides/routing.md` remains the sole selected route; `guided` is recorded only as a wrapper modifier and is never an independent approval authority.

## Intake (Conductor)

Ask:
1. Target workflow or operation.
2. Goal, constraints, and requested stopping point.
3. Step confirmation style: each step or small batches.

## Inheritance contract

- Mutation class, allowed writes, plan artifact, approvals, execution owner, validation, terminal states, and completion evidence come unchanged from the target route.
- Guided step confirmation is additional user steering. It cannot satisfy, remove, or replace target-route approval.
- Optional 3-8 line micro-plans describe the next step only; they are not implementation plan artifacts unless the target row's full plan contract is met and explicitly approved.
- Playbook policy and sensitive-command approvals still apply inside the target route.
- Switching to normal interaction changes cadence only; it does not reset or bypass gates.

## Procedure

1. Conductor selects exactly one target route, records `guided` as its modifier, completes target intake, and states inherited gates before the first step.
2. Propose the next step or small batch with intent, action, expected result, and quick check.
3. Wait for `continue`, `revise step`, `switch to normal`, or `stop`.
4. Before execution, enforce any target-route plan/preview/invocation approval that remains outstanding.
5. The inherited execution owner performs only the confirmed step scope and records its evidence.
6. The inherited validation owner runs the required per-step and terminal checks.
7. Repeat until the target route reaches its terminal state or the user stops; a stop maps to the target row's `blocked` state with the stop reason.

If scope changes route eligibility, stop and promote through normal routing. Prior step confirmations provide no approval for the promoted route.

## Done criteria

- Every executed step stayed inside inherited scope and ownership.
- All target-route gates and completion evidence remain intact.
- Closeout reports only the target row's terminal state, plus any stop reason, verification, and impact statuses.

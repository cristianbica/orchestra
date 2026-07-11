# Workflow: change (feature | bug | refactor)

This workflow implements non-trivial product/app changes. Its authoritative route contract is the `change` row in `.ai/agents/guides/routing.md`.

## Intake (Conductor)

Ask only for missing blocking facts:
1. Change type and goal: `feature`, `bug`, or `refactor`.
2. Success criteria, including expected/actual behavior and repro for bugs.
3. Constraints and material risk: compatibility, API/schema/UX, security/data, i18n, or role scope.

## Procedure

1. Conductor confirms the `change` route and records a reasoned overlay decision for delegated work.
2. By default Planner performs focused, read-only discovery and produces an executable inline or file plan. In opted-in Forger mode, Forger assumes this Planner phase and its plan-artifact writes.
3. The plan identifies scope/non-goals, critical files, reusable patterns, numbered steps, verification, and doc impact.
4. **Approval gate:** stop until the user explicitly approves that exact plan artifact.
5. By default Builder implements the approved plan. In opted-in Forger mode, Forger assumes this Builder phase and its approved product/source writes without delegating.
6. The Builder phase runs every applicable verification category and reports commands, outcomes, and skips.
7. By default Validator returns `approve` or `needs changes` after checking route eligibility, approval, plan adherence, diff scope, verification, docs, and memory. In opted-in Forger mode, Forger assumes this Validator phase and its allowed docs/memory writes.
8. Conductor maps review status to `complete`, `blocked`, or `failed` and reports completion evidence; Forger performs this coordination only inside explicitly selected single-agent mode.

## Playbooks and feedback

- A plan that invokes a playbook names its inputs, side effects, invocation policy, approvals, execution scope, and evidence.
- Plan approval authorizes only named playbook scope; stricter playbook gates still apply.
- Invocation approval never substitutes for approval of the `change` plan.
- Feedback after approval may be handled inside the same plan only when it does not materially change scope or approach; otherwise stop for a plan update and renewed approval.

## Outputs

- Explicitly approved inline plan or `.ai/plans/<YYYY-MM-DD>-<INDEX>-<slug>.md`.
- Scoped implementation diff and command-backed verification.
- Doc impact and memory impact.

## Done criteria

- The exact plan was explicitly approved before implementation and followed within scope.
- Every applicable check ran or has an explicit skip reason.
- Validator returned a review status, and Conductor mapped it to a route-valid terminal state with required evidence.

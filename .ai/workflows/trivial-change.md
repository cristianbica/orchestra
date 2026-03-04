# Workflow: trivial-change

## Intake (Conductor)
Conductor asks (only if unclear):
1) Confirm scope: Is this strictly formatting/typos/docs wording only (no behavior change)?
2) Target location: Which file(s)/section(s)?
3) Constraints: Any wording preferences or terminology to preserve?

Use ONLY for:
- Typo fixes, formatting, comments
- Small edits with no behavior changes (typically <= 10 lines)

Default overlays:
- None by default. Add only if explicitly needed.

Precedence:
- Workflow constraints for trivial scope override overlay guidance.

Steps:
1. Builder makes the minimal change.
2. Explicitly state: "trivial-change: <what> in <file>"
2a. No plan is required for this workflow.
2b. Builder must not request a plan for this workflow.
3. Doc impact: none (by definition)
4. Validator spot-checks (30 seconds max)

If you're unsure whether it's trivial → use `change` instead.

Outputs:
- The minimal change (no plan required)

Done criteria:
- Change is documented in the commit/PR description
- Validator confirmed it's genuinely trivial

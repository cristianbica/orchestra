# Workflow: trivial-change

## Intake (Conductor)
Conductor asks (only if unclear):
1) Confirm scope: Is this strictly formatting/typos/docs wording only (no behavior change)?
2) Target location: Which file(s)/section(s)?
3) Constraints: Any wording preferences or terminology to preserve?

Use ONLY for:
- Typo fixes, formatting, comments
- Small edits with no behavior changes (typically <= 10 lines)

Steps:
1. Builder makes the minimal change.
2. Explicitly state: "trivial-change: <what> in <file>"
3. Doc impact: none (by definition)
4. Inspector spot-checks (30 seconds max)

If you're unsure whether it's trivial → use fix-bug or refactor instead.

Outputs:
- The minimal change (no plan required)

Done criteria:
- Change is documented in the commit/PR description
- Inspector confirmed it's genuinely trivial

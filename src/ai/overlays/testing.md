# Overlay: testing

Purpose:
- Keep changes verifiable with focused, meaningful test coverage.
- Reduce regression risk by matching tests to the critical behavior being changed.

When to apply:
- Feature, bug, refactor, and reliability-sensitive work where verification matters.
- Changes that affect critical flows, invariants, or failure handling.

Output focus:
- Clear verification strategy tied to real risk.
- Test coverage for critical paths and likely regressions.
- Practical test scope instead of blanket over-testing.

Decision prompts:
- What could regress here first?
- Which tests would prove the change works and remains safe?
- Are the most important behaviors easy to verify repeatedly?

Quality checks:
- Verification is explicit and proportionate.
- Critical-path behavior is covered before edge cases expand scope.
- Test strategy matches the actual risk of the change.

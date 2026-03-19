# Overlay: review

Purpose:
- Keep review work focused on regressions, risk, and maintainability.
- Reduce shallow review feedback that misses behavioral or operational impact.

When to apply:
- Code review, diff review, plan review, and validation-focused tasks.
- Work where the primary goal is to identify problems rather than implement.

Output focus:
- Highest-risk findings first.
- Clear rationale for bugs, regressions, or missing safeguards.
- Minimal noise and strong prioritization.

Decision prompts:
- What is most likely to break or regress?
- Which assumptions are weak or unverified?
- What is missing that would make this safer to ship?

Quality checks:
- Findings are concrete and prioritized.
- Review comments focus on behavior and risk, not style trivia.
- Missing verification or safeguards are called out explicitly.

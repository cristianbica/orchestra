# Overlay: system

Purpose:
- Preserve architectural consistency and core system constraints.
- Favor maintainable designs over short-term convenience.

When to apply:
- Design decisions, cross-module changes, and integration work.
- Refactors, interface changes, and dependency updates.

Output focus:
- Explicit boundaries (what changes, what remains stable).
- Dependency impact and coupling risk.
- Fit with existing patterns and conventions.

Decision prompts:
- Which layers/modules are affected directly and indirectly?
- Does this introduce new coupling or hidden side effects?
- Is there a simpler design with equivalent outcome?

Quality checks:
- Architecture rationale is stated, not assumed.
- Backward compatibility/transition concerns are addressed.
- Verification includes impacted integration paths.

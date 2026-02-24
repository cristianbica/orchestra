# Overlay: security

Purpose:
- Reduce security and privacy risk in planned and implemented changes.
- Ensure risk is identified early and mitigated proportionally.

When to apply:
- Auth/authz, sensitive data handling, external inputs, and dependency risk.
- Public endpoints, secrets/config changes, and high-blast-radius updates.

Output focus:
- Threat-aware decisions with explicit assumptions.
- Least-privilege posture and trust-boundary awareness.
- Concrete safeguards, monitoring, and rollback readiness.

Decision prompts:
- What could be abused, leaked, or escalated by this change?
- Are permissions broader than strictly required?
- Which controls detect or limit failure impact quickly?

Quality checks:
- Input/authorization boundaries are explicit.
- Sensitive data exposure is minimized and justified.
- Mitigations are specific, testable, and actionable.

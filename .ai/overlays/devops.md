# Overlay: devops

Purpose:
- Keep deployment and post-deployment behavior safe, observable, and reversible.
- Reduce runtime surprises caused by config, rollout, or environment drift.

When to apply:
- Deployment, environment, rollout, rollback, and runtime operations changes.
- Work that changes how software is configured, shipped, or operated.

Output focus:
- Safe rollout and rollback expectations.
- Clear operational visibility and environment assumptions.
- Runtime behavior that is supportable after deployment.

Decision prompts:
- How is this deployed, configured, and rolled back safely?
- What will operators need to observe or diagnose after release?
- Are environment-specific assumptions explicit?

Quality checks:
- Rollout and rollback paths are clear.
- Operational signals are sufficient to detect failure quickly.
- Environment and config dependencies are explicit.

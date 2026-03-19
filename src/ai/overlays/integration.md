# Overlay: integration

Purpose:
- Keep third-party and external system integrations robust and explicit.
- Reduce hidden coupling at service and provider boundaries.

When to apply:
- External API clients, provider integrations, webhooks, and cross-system sync flows.
- Changes that depend on third-party behavior or network boundaries.

Output focus:
- Clear boundary ownership and integration assumptions.
- Failure-aware behavior across provider dependencies.
- Explicit contract mapping between internal models and external systems.

Decision prompts:
- What assumptions are we making about the external system?
- How do failures, retries, and partial success behave?
- Where does boundary translation happen and who owns it?

Quality checks:
- Third-party assumptions are documented, not implied.
- Failure and retry behavior is concrete.
- Internal and external models are mapped deliberately.

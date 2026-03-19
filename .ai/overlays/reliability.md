# Overlay: reliability

Purpose:
- Keep software behavior resilient when dependencies, inputs, or runtime conditions fail.
- Reduce user-visible breakage from retries, duplicates, partial failure, and recovery gaps.

When to apply:
- Retry logic, error handling, idempotency, degradation, and recovery-sensitive changes.
- Work where resilience matters more than a simple happy-path implementation.

Output focus:
- Explicit failure modes and recovery behavior.
- Stable handling of retries, duplicates, and partial success.
- Graceful behavior under degraded conditions.

Decision prompts:
- What happens when this fails halfway through?
- Is the behavior safe under retries or duplicate delivery?
- How does the system degrade or recover under stress?

Quality checks:
- Failure handling is concrete, not implied.
- Retry/idempotency assumptions are addressed.
- Recovery and degraded behavior are proportionate to risk.

# Pattern: architecture

- Keep responsibilities clear (UI vs domain vs infrastructure).
- Prefer small, composable modules/services over large controllers/components.
- Apply workflow > role > overlay precedence when coordinating agent work.
- Treat overlays as supporting context; workflow gates and approved plans win on conflicts.
- Forger mode is additive and opt-in only: single-agent, non-delegating execution that does not relax plan approval gates.
- Document new conventions in `.ai/docs/patterns/` when introduced.

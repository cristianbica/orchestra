# Pattern: architecture

- Application architecture is unverified until repository entry points,
  boundaries, and dependency direction are inspected.
- Replace this placeholder with concrete module paths and one or two
  representative dependency flows; label remaining unknowns.
- Apply workflow/operation/role/playbook/overlay boundaries when coordinating agent work.
- Use `.ai/agents/guides/routing.md` as the canonical route, gate, ownership, and
  completion contract instead of duplicating its matrix here.
- Treat overlays as supporting context; workflow gates, operation gates, approved plans, and stricter playbook approval requirements win on conflicts.
- Forger mode is additive and opt-in only: single-agent, non-delegating execution that does not relax the selected route's gates.
- Document new conventions in `.ai/docs/patterns/` when introduced.

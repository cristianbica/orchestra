---
description: Implementation agent. Follows the selected route's approved plan or eligible planless scope.
mode: subagent
permission:
  edit: ask
  bash: ask
  task: deny
---

This is a thin wrapper for the canonical Builder definition.

1. Read `.ai/agents/builder.md`.
2. Follow it as the source of truth.
3. If anything in this wrapper conflicts with `.ai/agents/builder.md`, the canonical file wins.

Follow `.ai/agents/guides/routing.md` for the selected route's gate. Explicitly eligible `trivial-change` work is planless; non-trivial `change` implementation requires approval of its inline or `.ai/plans/**` plan artifact.

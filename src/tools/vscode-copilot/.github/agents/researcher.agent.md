```chatagent
---
name: Researcher
description: Investigate and reduce uncertainty with evidence. Produces an investigation report and recommends the next workflow.
argument-hint: Explore options, map a feature end-to-end, or find root cause. Read-only by default; ask permission for temporary instrumentation.
target: vscode
user-invokable: true
disable-model-invocation: false
tools: ['vscode', 'execute', 'read', 'agent', 'edit', 'search', 'web', 'memory', 'todo']
---

This is a thin wrapper for the canonical Researcher definition.

Follow the authoritative instructions in [../../.ai/agents/researcher.md](../../.ai/agents/researcher.md). If anything here conflicts with the canonical file, the canonical file wins.

```

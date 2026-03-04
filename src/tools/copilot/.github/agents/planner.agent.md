---
name: Planner
description: Investigate and plan with evidence. Produces executable plans for non-trivial changes.
argument-hint: Investigate quickly, resolve uncertainty, and produce a scannable plan in .ai/plans/.
target: vscode
user-invokable: true
disable-model-invocation: false
tools: ['vscode', 'execute', 'read', 'agent', 'edit', 'search', 'web', 'memory', 'todo']
---

This is a thin wrapper for the canonical Planner definition.

Follow the authoritative instructions in [../../.ai/agents/planner.md](../../.ai/agents/planner.md). If anything here conflicts with the canonical file, the canonical file wins.

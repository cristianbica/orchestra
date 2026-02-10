---
name: Architect
description: Plan changes only, producing executable plans and optional task breakdowns.
argument-hint: Do discovery, ask clarifying questions, and write a plan to .ai/plans/.
target: vscode
user-invokable: true
disable-model-invocation: false
tools: ['vscode', 'execute', 'read', 'agent', 'edit', 'search', 'web', 'memory', 'todo']
---

This is a thin wrapper for the canonical Architect definition.

Follow the authoritative instructions in [../../.ai/agents/architect.md](../../.ai/agents/architect.md). If anything here conflicts with the canonical file, the canonical file wins.

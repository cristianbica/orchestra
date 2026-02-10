---
name: Archivist
description: Keep .ai/docs accurate and high-signal; document changes only.
argument-hint: Update affected docs and memory when durable facts appear.
target: vscode
user-invokable: true
disable-model-invocation: false
tools: ['vscode', 'execute', 'read', 'agent', 'edit', 'search', 'web', 'memory', 'todo']
---

This is a thin wrapper for the canonical Archivist definition.

Follow the authoritative instructions in [../../.ai/agents/archivist.md](../../.ai/agents/archivist.md). If anything here conflicts with the canonical file, the canonical file wins.

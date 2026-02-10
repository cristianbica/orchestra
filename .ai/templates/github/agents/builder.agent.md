---
name: Builder
description: Implement approved plans with minimal, safe changes and clear verification.
argument-hint: Implement only an approved plan, keep scope tight, and report verification.
target: vscode
user-invokable: true
disable-model-invocation: false
tools: ['vscode', 'execute', 'read', 'agent', 'edit', 'search', 'web', 'memory', 'todo']
---

This is a thin wrapper for the canonical Builder definition.

Follow the authoritative instructions in [../../.ai/agents/builder.md](../../.ai/agents/builder.md). If anything here conflicts with the canonical file, the canonical file wins.

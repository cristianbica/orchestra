---
name: Forger
description: Execute approved work end-to-end in one agent with explicit phase switches and no subagent delegation.
argument-hint: Run single-agent mode only when explicitly selected, keep scope tight, and preserve approval gates.
target: vscode
user-invokable: true
disable-model-invocation: false
tools: ['vscode', 'execute', 'read', 'agent', 'edit', 'search', 'web', 'memory', 'todo']
---

This is a thin wrapper for the canonical Forger definition.

Follow the authoritative instructions in [../../.ai/agents/forger.md](../../.ai/agents/forger.md). If anything here conflicts with the canonical file, the canonical file wins.

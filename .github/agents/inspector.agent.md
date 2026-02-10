---
name: Inspector
description: Review changes for correctness, plan adherence, and gate checks.
argument-hint: Review only, produce must-fix vs optional feedback, and enforce gates.
target: vscode
user-invokable: true
disable-model-invocation: false
tools: ['vscode', 'execute', 'read', 'agent', 'edit', 'search', 'web', 'memory', 'todo']
---

This is a thin wrapper for the canonical Inspector definition.

Follow the authoritative instructions in [../../.ai/agents/inspector.md](../../.ai/agents/inspector.md). If anything here conflicts with the canonical file, the canonical file wins.

---
name: Validator
description: Validate changes for correctness, plan adherence, and doc/memory hygiene.
argument-hint: Validation only, produce must-fix vs optional feedback, and enforce gates.
target: vscode
user-invokable: true
disable-model-invocation: false
tools: ['vscode', 'execute', 'read', 'agent', 'edit', 'search', 'web', 'memory', 'todo']
---

This is a thin wrapper for the canonical Validator definition.

Follow the authoritative instructions in [../../.ai/agents/validator.md](../../.ai/agents/validator.md). If anything here conflicts with the canonical file, the canonical file wins.

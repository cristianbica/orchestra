---
name: Conductor
description: Orchestrate workflows, enforce plan gates, and route work to other agents.
argument-hint: Route to the smallest workflow, ask only blocking questions, and enforce plan approval.
target: vscode
user-invokable: true
disable-model-invocation: false
tools: ['vscode', 'execute', 'read', 'agent', 'edit', 'search', 'web', 'memory', 'todo']
---

This is a thin wrapper for the canonical Conductor definition.

Follow the authoritative instructions in [../../.ai/agents/conductor.md](../../.ai/agents/conductor.md). If anything here conflicts with the canonical file, the canonical file wins.

## Shortcut Support

Conductor now recognizes seven shortcut phrases to speed up common workflows:

- **"bootstrap this"** or **"bootstrap"** → Run `.ai/plans/01-bootstrap.md` directly
- **"refresh context"** → Run `.ai/plans/02-refresh-context.md` directly
- **"implement feature"** → implement-feature workflow + intake questions
- **"document"** → document workflow + intake questions
- **"trivial change"** → trivial-change workflow + intake questions
- **"fix bug"** → fix-bug workflow + intake questions
- **"refactor"** → refactor workflow + intake questions

See "Shortcut Detection" section in the canonical definition for full details, examples, and routing behavior.

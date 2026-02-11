# Humans: how to use this repo’s AI system


## Examples

### Implement a feature (plan gate enforced)

```
User: Conductor implement feature: add a dark mode toggle

Conductor: asks 1–3 intake questions
Architect: writes a plan in .ai/plans/
User: explicitly approves the plan
Builder: implements ONLY the approved plan
Inspector: reviews for correctness + plan adherence
Archivist: updates docs/memory as needed
```

### Fix a bug

```
User: Conductor fix bug: API returns stale cached data

Conductor: intake questions (expected vs actual, repro, evidence)
Architect: writes a fix plan
Builder: implements the fix
Inspector: verifies the change matches the plan
```

### Investigate (timeboxed, read-only by default)

```
User: Conductor investigate: figure out why billing exports are slow

Conductor: asks 1–3 intake questions (question, references, constraints + timebox)
Researcher: investigates and writes an evidence-backed report in .ai/plans/
Conductor: confirms recommended handoff to fix-bug / refactor / implement-feature / document
```

### Refactor code (plan gate enforced)

```
User: Conductor refactor: clean up user authentication flow
Conductor: asks 1–3 intake questions
Architect: writes a refactor plan in .ai/plans/
User: explicitly approves the plan
Builder: implements ONLY the approved plan
Inspector: reviews for correctness + plan adherence
Archivist: updates docs/memory as needed
```

### Fix a security issue (plan gate enforced)

```
User: Conductor fix security issue: patch vulnerable dependency
Conductor: asks 1–3 intake questions (vulnerability details, repro, evidence)
Architect: writes a security fix plan in .ai/plans/
User: explicitly approves the plan
Builder: implements ONLY the approved plan
Inspector: reviews for correctness + plan adherence
Archivist: updates docs/memory as needed
```

### Update documentation

```
User: Conductor document: update API docs for user endpoints
Conductor: asks 1–3 intake questions (target doc, audience/intent, source of truth)
Archivist: updates docs based on intake answers
```

### Refresh context

```
User: Conductor refresh context
Conductor: routes to Archivist to execute refresh plan
Archivist: executes context refresh plan in .ai/plans/02-refresh-context.md
```

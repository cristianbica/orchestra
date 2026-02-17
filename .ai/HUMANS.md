# Humans: how to use this repo’s AI system


## Examples

### Implement a feature (plan gate enforced)

```
User: Conductor change: feature add a dark mode toggle

Conductor: asks 1–3 intake questions
Planner: investigates as needed, then writes a plan in .ai/plans/
User: explicitly approves the plan
Builder: implements ONLY the approved plan
Validator: reviews for correctness + plan adherence and updates docs/memory as needed
```

### Fix a bug

```
User: Conductor fix bug: API returns stale cached data

Conductor: intake questions (expected vs actual, repro, evidence)
Planner: writes a fix plan
Builder: implements the fix
Validator: verifies the change matches the plan and docs/memory gates
```

### Investigate (timeboxed, read-only by default)

```
User: Conductor investigate: figure out why billing exports are slow

Conductor: asks 1–3 intake questions (question, references, constraints + timebox)
Planner: investigates and writes an evidence-backed report in .ai/plans/
Conductor: confirms recommended handoff to change / document
```

### Refactor code (plan gate enforced)

```
User: Conductor refactor: clean up user authentication flow
Conductor: asks 1–3 intake questions
Planner: writes a refactor plan in .ai/plans/
User: explicitly approves the plan
Builder: implements ONLY the approved plan
Validator: reviews for correctness + plan adherence and updates docs/memory as needed
```

### Fix a security issue (plan gate enforced)

```
User: Conductor fix security issue: patch vulnerable dependency
Conductor: asks 1–3 intake questions (vulnerability details, repro, evidence)
Planner: writes a security fix plan in .ai/plans/
User: explicitly approves the plan
Builder: implements ONLY the approved plan
Validator: reviews for correctness + plan adherence and updates docs/memory as needed
```

### Update documentation

```
User: Conductor document: update API docs for user endpoints
Conductor: asks 1–3 intake questions (target doc, audience/intent, source of truth)
Validator: updates docs based on intake answers
```

### Refresh context

```
User: Conductor refresh context
Conductor: routes to Validator to execute refresh plan
Validator: executes context refresh plan in .ai/plans/02-refresh-context.md
```

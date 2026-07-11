# Playbook: <name>

## Purpose

- <reusable procedure and expected result>

## Use when

- <concrete trigger>

## Do not use when

- <clear exclusion or promotion condition>

## Invocation policy

- Mode: `suggest-first` # auto | suggest-first | explicit-only
- Allowed roles: `<planner | builder | validator | forger>`
- Requires approval before execution: `yes`
- Requires approval before steps:
  - <step, resource, or risk and required scope; or none>
- Enclosing route/plan requirement: <route and approved plan requirement; or none>

## Risk profile

- Side effects: `<none | starts-server | writes-files | mutates-db | external-network | production-access | other>`
- Write/artifact paths: <normalized bounded paths, or none>
- Data sensitivity: `<none | local-only | user-data | production-derived | secrets>`
- External or paid systems: <systems and account scope, or none>
- Expected duration: <timebox>

## Inputs

Required:
- <input name>: <description and validation>

Optional:
- <input name>: <description and default>

## Runtime questions

Ask only when a required input is missing:
1. <scoped question>

## Steps

1. <setup>
2. <ordered execution>
3. <evidence capture>

## Commands

- `<exact command, working directory, timeout, and expected side effects>`

## May call

- <direct child playbook slug, or none>

## Cleanup

- On success: <run-owned resources to stop/remove and verification>
- On failure: <run-owned resources to stop/remove and verification>
- Rollback: <named snapshot/manifest/transaction and restore verification, or unavailable>

## Evidence to report

- <preflight facts, approvals, command summary, files/artifacts, child results, cleanup, residual risk>

## Failure handling

- <stop conditions, partial-result handling, cleanup, and escalation>

## Terminal contract

- Allowed terminal states: `<complete | blocked | failed | rolled back>`
- `complete`: <required success and cleanup evidence>
- `blocked`: <missing gate/input evidence>
- `failed`: <failure and cleanup evidence, or not allowed>
- `rolled back`: <restoration evidence, or not allowed>

## Verification status

- Status: `<draft | provisional | verified | deprecated>`
- Last verified: `<YYYY-MM-DD or unknown>`
- Verification notes: <commands/evidence run, or unverified claims requiring acknowledgement>

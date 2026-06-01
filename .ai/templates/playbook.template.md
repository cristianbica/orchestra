# Playbook: <name>

## Purpose

- <what reusable procedure this performs>

## Use when

- <when an agent should consider this playbook>

## Do not use when

- <clear exclusion cases>

## Invocation policy

- Mode: `suggest-first`
- Allowed roles: `<planner | builder | validator | forger>`
- Requires approval before execution: `yes`
- Requires approval before steps:
  - <step or risk, if any>

## Risk profile

- Side effects: `<none | starts-server | writes-files | mutates-db | external-network | production-access | other>`
- Data sensitivity: `<none | local-only | user-data | production-derived | secrets>`
- Expected duration: `<timebox>`
- Cleanup required: `<yes/no + what>`

## Inputs

Required:
- <input name>: <description>

Optional:
- <input name>: <description>

## Runtime questions

Ask only when required inputs are missing:
1. <question>

## Steps

1. <step>
2. <step>
3. <step>

## Commands

- `<command>`

## May call

- <child playbook slug, or none>

## Evidence to report

- <command output summary, files written, screenshots, data provenance, cleanup status>

## Failure handling

- <how to stop, clean up, and report partial results>

## Verification status

- Status: `<draft | provisional | verified | deprecated>`
- Last verified: `<YYYY-MM-DD or unknown>`
- Verification notes: <what was run or why it is provisional>

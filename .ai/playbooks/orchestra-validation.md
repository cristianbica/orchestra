# Playbook: Orchestra Validation

## Purpose

- Validate the Orchestra template installer, Codex adapter metadata, and adapter smoke expectations for this repository.

## Use when

- Changes touch `install.sh`, `scripts/verify.sh`, `src/ai/**`, or `src/tools/**`.
- A workflow needs the standard repo smoke check before closeout.

## Do not use when

- The task only edits unrelated `.ai/docs/**` wording or historical plans.
- The user explicitly asks not to run verification.

## Invocation policy

- Mode: `suggest-first`
- Allowed roles: `builder`, `validator`, `forger`
- Requires approval before execution: `yes`
- Requires approval before steps:
  - none

## Risk profile

- Side effects: `writes-files` in temporary directories created by `scripts/verify.sh`
- Data sensitivity: `none`
- Expected duration: under 1 minute
- Cleanup required: handled by `scripts/verify.sh` trap cleanup

## Inputs

Required:
- none

Optional:
- none

## Runtime questions

Ask only when required inputs are missing:
1. none

## Steps

1. Run the installer shell syntax check.
2. Run the repo verification smoke script.
3. Report exact commands and outcomes.

## Commands

- `bash -n install.sh`
- `scripts/verify.sh`

## May call

- none

## Evidence to report

- Command names.
- Exit status.
- Final `scripts/verify.sh` summary line.
- Any failure output from the first failing command.

## Failure handling

- Stop at the first failing command.
- Report whether the failure is installer syntax, adapter metadata, install smoke behavior, or verification-script behavior.
- Do not modify generated temporary directories; `scripts/verify.sh` owns cleanup.

## Verification status

- Status: `verified`
- Last verified: `2026-05-24`
- Verification notes: `bash -n install.sh` and `scripts/verify.sh` both passed during playbook implementation.

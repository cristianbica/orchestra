# Playbook: Quality Test

## Purpose

Measure whether bootstrapped Orchestra improves a clean-room implementation of a real merged public PR.

Compare `vanilla/` (direct task), `orchestra/` (current local Orchestra, bootstrap, plan, implement), optional `orchestra-<ref>/` (one branch or SHA), and `actual/` (real PR inspected last).

## Use when

- An Orchestra maintainer explicitly requests an end-to-end quality evaluation against a real public Ruby PR.

## Do not use when

- The request is local-only validation of this repository, requires sensitive or paid resources, or cannot preserve the clean-room boundary.

## Invocation policy

- Mode: `explicit-only`
- Allowed roles: `builder`; `forger` only when explicitly requested for the run
- Requires approval before execution: `yes`
- Requires approval before steps:
  - The exact approved command plan must cover every expanded command, its working directory, timeout, expected writes, network access, permissions, and cleanup.
- Enclosing route/plan requirement: `run-playbook`; an approved `change` plan is also required before any non-trivial product/app mutation.
- The caller selects one runner: `codex`, `opencode`, `claude`, or `copilot`; they may request one additional Orchestra branch or SHA.
- Use `/tmp/orchestra-quality-test/<run-id>/`, 60-minute agent-command limits, and preserve the workspace until reporting completes.
- Before any workspace, install, dependency, implementation, test, or actual-reference command, show the selected PR and every expanded command in an inline plan and obtain approval.

The approved plan must name:
- workspace paths, working directory, timeout, expected writes, and network access for every command, including `bundle install`;
- selected runner/model, pinned base, optional ref, project checks, and cleanup;
- public-network access, temporary-workspace writes, dependency installation, and the selected runner's unattended full-permission mode.

## Risk profile

- Side effects: `external-network`, `writes-files`, dependency installation, generated implementation edits in temporary workspaces, and long-running processes
- Write/artifact paths: `/tmp/orchestra-quality-test/<run-id>/**` only, including run-owned logs and evidence
- Data sensitivity: `none`; stop if secrets, private repositories, production or production-derived data are encountered
- External or paid systems: public GitHub, package registries, and the selected runner account; paid services are prohibited
- Expected duration: 60 minutes per runner command, plus the approved run timebox

## Inputs

Required:
- PR: the named public merged PR or authorization to select one matching the stated Ruby and size constraints
- Runner: one of `codex`, `opencode`, `claude`, or `copilot`
- Current Orchestra source: this checkout for `orchestra/`
- Run ID: a unique value used only below `/tmp/orchestra-quality-test/`
- Exact-command approval: approval of the selected PR and all expanded commands, permissions, timeouts, writes, network access, project checks, and cleanup

Optional:
- Orchestra ref: one branch or SHA for `orchestra-<ref>/`; absent by default

## Runtime questions

Ask only when a required input is missing:
1. Which permitted runner and optional Orchestra ref should be used?
2. Do you approve the exact-command plan for this selected PR and run ID?

## Steps

### Selection And Setup

1. Select a public merged Ruby PR automatically, preferably at least 10 files and 300 changed lines. Require a `Gemfile` and bounded `bundle install`; record its URL, base, head, title, description, linked issue, and change statistics.
2. Before generated runs finish, inspect only that metadata and the pre-PR base checkout. Use the base only to discover `bundle install` and the smallest verification commands; reject repositories requiring PostgreSQL, MySQL, Redis, Docker, browsers, queues, or other external services. Do not inspect PR patches, changed files, head/merge commits, branch diffs, or implementation-equivalent evidence.
3. Clone the same detached pinned base into `vanilla/` and `orchestra/`; create `orchestra-<ref>/` only when requested. Run `bundle install` in every generated implementation workspace before bootstrap or implementation. Create or inspect `actual/` only after generated implementations and checks complete.
4. Install current local Orchestra in `orchestra/` with `SRC_DIR=<current-orchestra-root> sh <current-orchestra-root>/install.sh <runner>`. Install the optional workspace with `curl -fsSL https://raw.githubusercontent.com/cristianbica/orchestra/<ref>/install.sh | REF=<ref> sh -s -- <runner>`.

### Runs

1. Bootstrap `orchestra/` and optional `orchestra-<ref>/`; never bootstrap `vanilla/` or `actual/`. Bootstrap reads only the detached base checkout, may create `.ai/**`, and must preserve a log plus a generated-context summary. Exclude its tokens, time, and cost; stop before implementation if it fails or crosses the clean-room boundary.
2. Run the same clean-room task directly in `vanilla/`.
3. In each bootstrapped Orchestra workspace, write `.ai/plans/quality-test.md`, then run the fixed approval prompt to implement it. Both commands are measured and the plan is comparison evidence.
4. Use the same task, runner/model, time limit, clean-room constraint, and project checks for every implementation. Record a log, changed files, elapsed time, and tool-reported tokens; use `not reported by tool` when unavailable. For every runner command, wait for its process to reach an actual exit or its timeout, confirm the process is no longer running, and record its PID, exit status, and timeout result. JSONL events (including Codex `--json` output) are progress evidence only and never establish completion.
5. Run the discovered project checks in every generated workspace. Only then inspect `actual/` at the PR head or merge commit and compare it with the generated plans and implementations.

Clean-room rule:
- No generated run may inspect the selected PR, patch/diff, changed files, merge commit, or another solution.
- All writes stay in the temporary workspaces.
- Stop for secrets, private repositories, production data, paid services, unsafe install scripts, privileged host access, a clean-room exposure, bootstrap failure, or an unsupported unattended runner.

## Commands

Use the selected form for bootstrap, vanilla implementation, Orchestra planning, and Orchestra implementation. Replace `<workspace>` and `<prompt>` in the approved inline plan.

- Codex: `timeout 60m codex exec -C <workspace> --json --dangerously-bypass-approvals-and-sandbox "<prompt>"`
- OpenCode: `cd <workspace> && timeout 60m opencode run --auto "<prompt>"`
- Claude Code: `cd <workspace> && timeout 60m claude -p --output-format json --dangerously-skip-permissions "<prompt>"`
- GitHub Copilot CLI: `cd <workspace> && timeout 60m copilot -p "<prompt>" --allow-all`

- Bootstrap: `Bootstrap this repo - everything is pre-approved, you are running unattended. Work only in this checkout and do not inspect any PR, patch, diff, or other implementation-equivalent evidence.`
- Vanilla: `Implement <task> - everything is pre-approved, you are running unattended; you are not allowed to inspect any PR that might have solved this - clean room implementation.`
- Orchestra plan: `Write a plan to implement <task>; you are not allowed to inspect any PR that might have solved this - clean room implementation; write the plan in .ai/plans/quality-test.md.`
- Orchestra implementation: `Plan .ai/plans/quality-test.md approved. Implement it - everything is pre-approved, you are running unattended; you are not allowed to inspect any PR that might have solved this - clean room implementation.`

## May call

- none

## Evidence to report

Report:
- selected PR, pinned base, runner/model, optional ref, and exact approved commands;
- generated Orchestra plans, files changed, and project-check results;
- implementation-only tokens and elapsed time, with `not reported by tool` where needed;
- correctness, architecture, file coverage, test coverage, and risk-handling differences from `actual/`.

Preserve logs and partial evidence on failure. After the report, apply the cleanup declared in the approved inline plan; preserve evidence even when deleting workspaces.

## Cleanup

- On success: after reporting, apply the exact approved cleanup to only run-owned `/tmp/orchestra-quality-test/<run-id>/` workspaces; verify and report retained evidence or removal.
- On failure: preserve logs and partial evidence, then apply the same bounded run-owned cleanup when safe; report any residual workspace or process.
- Rollback: unavailable; generated implementation changes are isolated temporary artifacts and are not applied to this repository.

## Failure handling

- Stop before any unapproved command, write, network action, permission, or timeout; stop on clean-room exposure, unsafe install script, unsupported unattended runner, secret/private/production/paid-service access, or a runner that does not exit before its timeout.
- Preserve partial command, PID, timeout, exit-status, log, changed-file, and token evidence; run bounded failure cleanup and report residuals.

## Terminal contract

- Allowed terminal states: `complete`, `blocked`, `failed`
- `complete`: every runner process reached a recorded successful terminal exit, all project checks completed, actual was inspected only afterward, the report is complete, and cleanup evidence is recorded.
- `blocked`: a required input, exact-command approval, permitted runner, or approved environment fact is missing before execution.
- `failed`: execution stopped on a declared failure condition or a non-successful/timeout runner exit; partial evidence and cleanup status are recorded.

## Verification status

- Status: `provisional`
- Last verified: `2026-07-11`
- Verification notes: The compact flow and runner forms were reviewed; this version has not been run end to end.

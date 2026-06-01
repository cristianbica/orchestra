# Playbook: Quality Test

## Purpose

- Evaluate Orchestra quality by reimplementing a real merged open-source PR in isolated workspaces, then comparing a vanilla CLI implementation, an Orchestra-guided CLI implementation, and the actual PR implementation.

## Use when

- An Orchestra maintainer explicitly requests an end-to-end quality evaluation against a real public GitHub repository.
- The goal is to test planning, bootstrap context, workflow gates, unattended CLI execution, implementation guidance, verification evidence, token cost, time cost, and final comparison quality.

## Do not use when

- The user has not explicitly approved this playbook for the run.
- The target work is local-only validation of this repository; use `orchestra-validation.md` instead.
- The task requires secrets, production credentials, production or production-derived data, paid services, private repositories, or destructive actions.
- The evaluator or any implementation run must inspect the real PR implementation before the vanilla and Orchestra implementations and their verification are complete.
- The selected repository requires unsafe install scripts, unbounded setup, privileged host access, or access outside the approved temporary workspace.

## Invocation policy

- Mode: `explicit-only`
- Allowed roles: `builder`; `forger` only when explicitly opted in for the run
- Execution model: CLI-driven unattended runs after one upfront run approval; do not use current-session subagents as the implementation executors
- Requires approval before execution: `yes`
- Requires approval before steps: `no`; the upfront unattended run approval must cover the full allowed action set below

Unattended run approval must explicitly cover:
- GitHub and other required external network access for metadata, cloning, dependency installation, and tool execution.
- Creating three isolated workspaces under the approved temporary parent directory: `orchestra/`, `vanilla/`, and `actual/` or a diff-only reference area.
- Installing Orchestra in the `orchestra/` workspace only.
- Running the configured `<tool-cli>` and `<runtime-tool-name>` commands; both default to `codex` unless the caller provides different values.
- Running discovered dependency, build, lint, test, and project-specific verification commands inside the isolated workspaces.
- Allowing implementation edits inside `orchestra/` and `vanilla/` only.
- Inspecting the final actual PR diff, merge commit diff, or reference implementation only after both CLI implementations and their verification are complete.
- Preserving or cleaning up the temporary workspace according to the approved cleanup preference.

Hard stops:
- Stop before using secrets, private repositories, production credentials, production data, production-derived data, paid services, destructive commands, privileged host operations, or unsafe install scripts.
- Stop if the PR implementation, patch body, branch diff, merge commit diff, changed file contents, or equivalent implementation detail is accidentally exposed before both implementations and verification are complete.
- Stop if a command attempts to write outside the approved temporary workspaces or requires permissions beyond the upfront approval.

## Risk profile

- Side effects: `external-network`, `writes-files`, dependency installation, generated code in temporary workspaces, possible long runtime
- Data sensitivity: `none` unless the selected repository, local configuration, environment, or tool account exposes secrets
- Expected duration: caller-provided timebox for the full evaluation plus per-run timeboxes for CLI implementations
- Cleanup required: `yes`; remove or preserve the temporary workspace according to the caller's cleanup preference

Trust boundary:
- Treat external OSS code, package manifests, install scripts, test commands, and generated implementation edits as untrusted.
- Run only inside the approved temporary workspace parent.
- Do not use secrets, production credentials, private accounts, paid services, or production-like data.
- Keep the real PR implementation unavailable to both CLI implementation runs until their edits and verification are complete.

## Inputs

Required:
- GitHub repository candidate or permission to choose one: public OSS repository to evaluate.
- Temporary workspace path: parent directory for `orchestra/`, `vanilla/`, and `actual/` or diff-only reference artifacts; default is `/tmp/orchestra-quality-test/<repo-slug>-<run-id>`.
- Tool CLI: command used for unattended implementation runs; default is `<tool-cli>=codex`.
- Runtime tool name: tool wrapper to install for Orchestra; default is `<runtime-tool-name>=codex`.
- Maximum runtime/timebox: stop condition for the full evaluation and for each unattended CLI implementation run; default is 4 hours for the full evaluation and 60 minutes for each unattended CLI implementation run.
- Cleanup preference: delete temporary workspace, preserve it, or ask before cleanup.

Optional:
- Local Orchestra source path: use when testing the current checkout with `SRC_DIR=<orchestra-root> sh install.sh <runtime-tool-name>`.
- PR selection constraints: labels, language, project area, age, or complexity bounds stricter than the defaults.
- Actual implementation mode: full `actual/` checkout or diff-only reference after implementations and verification are complete.

## Runtime questions

Ask only when required inputs or the upfront approval are missing:
1. Which public GitHub repository should be used, or may I choose one?
2. Use the default temporary workspace path `/tmp/orchestra-quality-test/<repo-slug>-<run-id>`, or provide a different parent path?
3. Use the default timeboxes of 4 hours total and 60 minutes per unattended CLI implementation run, or provide different limits?
4. Do you approve one unattended run covering GitHub/network access, clone/worktree creation, Orchestra install, CLI execution, dependency/test commands, implementation edits, final PR diff inspection only after both implementations and verification are complete, and the selected cleanup behavior?
5. Should the temporary workspace be deleted, preserved, or confirmed before cleanup?

## Steps

1. Confirm the user explicitly approved this playbook run, the upfront unattended action set, the timebox, `<tool-cli>`, `<runtime-tool-name>`, the temporary workspace path, and cleanup preference.
2. Select a recent merged PR using metadata-only commands. The PR should have enough substance to evaluate quality, preferably `changedFiles >= 10` and `additions + deletions >= 300`.
3. Record non-inspection proof:
   - Exact metadata commands run.
   - Confirmation that no PR file patches, PR file diffs, merge commit diff, branch diff, changed file contents, or implementation-equivalent artifacts were opened before implementation.
4. Use only acceptable pre-implementation evidence:
   - PR title.
   - PR description.
   - Linked issue or user-facing acceptance notes.
   - Changed-file count.
   - Addition/deletion stats.
   - Dates.
   - Labels.
5. Create three isolated workspaces from the same pinned pre-PR base commit, preferably `baseRefOid` from GitHub PR metadata:
   - `orchestra/`: install Orchestra and run the request through Orchestra via CLI.
   - `vanilla/`: run the same implementation request with the same `<tool-cli>` and no Orchestra context.
   - `actual/`: checkout or materialize the real PR implementation only after both CLI implementations and their verification are complete, or store a diff-only reference if a full checkout is unnecessary.
6. Ensure both `orchestra/` and `vanilla/` are detached at the same pinned base commit. Do not check out a live base branch or other moving ref for implementation.
7. Install Orchestra in `orchestra/` only. Do not install or copy Orchestra context into `vanilla/`.
8. Build a single implementation prompt from the allowed pre-implementation evidence. Enforce prompt parity:
   - Same PR metadata.
   - Same no-diff-before-implementation constraint.
   - Same timebox.
   - Same allowed commands and hard stops.
   - Same verification expectations.
9. Run the vanilla implementation unattended with `<tool-cli>` in `vanilla/`. Record command logs, timestamps, token usage, files changed, implementation summary, and verification results.
10. Run the Orchestra implementation unattended with `<tool-cli>` in `orchestra/`, using the installed Orchestra workflow and context. Record command logs, timestamps, token usage, generated `.ai/**` context summary, files changed, implementation summary, and verification results.
11. For both CLI runs, track token evidence when available:
   - Prompt/input tokens.
   - Completion/output tokens.
   - Total tokens.
   - Model.
   - Tool-reported timestamps and elapsed time.
   - Fallback value `not reported by tool` for any unavailable token or model field.
12. Run the most relevant target-project verification discovered during setup in both implementation workspaces, subject to the approved command set and hard stops. Record exact commands, exit status, timing, and failure details.
13. After both implementations and their verification are complete, inspect the actual PR implementation in `actual/` or as a diff-only reference.
14. Compare all three implementations: vanilla CLI vs Orchestra CLI vs actual PR.
15. Apply the approved cleanup preference. Preserve partial evidence and logs even if cleanup removes cloned repositories.

## Commands

Metadata-only examples:
- `gh pr list --repo <owner>/<repo> --state merged --limit 30 --json number,title,body,changedFiles,additions,deletions,mergedAt,baseRefName,baseRefOid,headRefName,labels,url`
- `gh pr view <number> --repo <owner>/<repo> --json number,title,body,changedFiles,additions,deletions,createdAt,mergedAt,baseRefName,baseRefOid,headRefName,headRefOid,labels,url`

Workspace setup examples:
- `mkdir -p <temp-workspace>/{orchestra,vanilla,actual}`
- `git clone https://github.com/<owner>/<repo>.git <temp-workspace>/orchestra`
- `git clone https://github.com/<owner>/<repo>.git <temp-workspace>/vanilla`
- `git -C <temp-workspace>/orchestra checkout --detach <baseRefOid>`
- `git -C <temp-workspace>/vanilla checkout --detach <baseRefOid>`

Orchestra install examples:
- `cd <temp-workspace>/orchestra && curl -fsSL https://raw.githubusercontent.com/cristianbica/orchestra/refs/heads/master/install.sh | sh -s -- <runtime-tool-name>`
- `cd <temp-workspace>/orchestra && SRC_DIR=<orchestra-root> sh install.sh <runtime-tool-name>`

Unattended CLI templates:
- `cd <temp-workspace>/vanilla && <tool-cli> "<shared-implementation-prompt>"`
- `cd <temp-workspace>/orchestra && <tool-cli> "<shared-implementation-prompt>"`

Actual reference examples, only after both implementations and verification are complete:
- `git clone https://github.com/<owner>/<repo>.git <temp-workspace>/actual`
- `git -C <temp-workspace>/actual checkout --detach <headRefOid-or-merge-commit>`
- `gh pr diff <number> --repo <owner>/<repo> > <temp-workspace>/actual/pr.diff`

Prohibited before both implementations and verification are complete:
- `gh pr diff <number>`
- `gh pr view <number> --patch`
- `git show <merge-commit>`
- `git diff <base>..<head>`
- Opening changed files from the PR branch or patch bodies from any source.

## May call

- none

## Evidence to report

- Project and PR URL.
- PR selection metadata, including changed-file count and additions/deletions.
- Proof of no pre-implementation diff access, including exact metadata commands.
- Upfront unattended run approval text or a concise reference to it.
- Workspace paths for `orchestra/`, `vanilla/`, and `actual/` or diff-only reference artifacts.
- Pinned pre-PR base commit, source of that commit such as `baseRefOid`, and checkout status for both implementation workspaces.
- Orchestra install command and result.
- Prompt parity evidence: shared prompt source, shared constraints, timeboxes, and allowed command set.
- Vanilla CLI run: command logs, timestamps, model, prompt/input tokens, completion/output tokens, total tokens, files changed, implementation summary, verification commands, exit status, timing, and failure details.
- Orchestra CLI run: command logs, timestamps, model, prompt/input tokens, completion/output tokens, total tokens, generated `.ai/**` context summary, files changed, implementation summary, verification commands, exit status, timing, and failure details.
- `not reported by tool` for any unavailable token, model, timestamp, or elapsed-time field.
- Actual PR reference source and final diff inspection commands.
- Three-way comparison across vanilla CLI, Orchestra CLI, and actual PR for behavior, architecture, file coverage, test coverage, verification results, docs/changelog, risk handling, implementation size, token cost, and time cost.
- Limitations, accidental exposure risks if any, and cleanup status.

## Failure handling

- Stop on missing upfront unattended run approval and report the missing approval.
- Stop on network/auth failure, unsafe repository requirements, unbounded install steps, missing usable verification commands, command attempts outside approved workspaces, or accidental PR implementation exposure.
- Stop if external code requests secrets, production credentials, private services, paid services, destructive commands, privileged host operations, or production-like data.
- Stop if the selected tool cannot run unattended within the approved timebox or cannot preserve command logs.
- Preserve partial evidence gathered so far, including commands run, timestamps, token reporting status, changed files, and outcomes.
- Apply the approved cleanup preference when safe; if cleanup itself is risky or unclear, ask before proceeding.

## Verification status

- Status: `provisional`
- Last verified: `2026-05-25`
- Verification notes: Updated from inspected local Orchestra docs, the playbook template, feature documentation, active overlays, memory, and the approved inline plan; this unattended three-way quality-test flow has not been executed.

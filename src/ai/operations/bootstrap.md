# Operation: Bootstrap

Initialize trusted Orchestra context in a target repository. This operation follows the `bootstrap` row in `.ai/agents/guides/routing.md`; it is not the `document` workflow and its preview is not a `change` plan.

## Intake and boundaries

Conductor records the target repository, desired context scope, constraints, permitted commands, exclusions, and acceptable side effects. Bootstrap may write only paths named in its approved preview, normally `.ai/docs/**` and `.ai/MEMORY.md` plus its run archive.

- Do not mutate product/app files. Stop and route that work to `change`.
- Do not run commands or perform broad writes while preparing the preview.
- Do not inspect historical plans under `.ai/plans/**`.
- Do not follow symlinks outside the target repository or archive data outside the approved scope.

## Approval gate

Before any command or broad write, Conductor presents one inline per-run preview containing:

- a timestamped UTC run ID (`YYYYMMDDTHHMMSSZ`, with a collision suffix when needed) and target root;
- exact commands, working directories, timeouts, expected outputs, and known side effects;
- normalized repository-relative read, write, create, archive, and cleanup paths;
- docs/features/patterns to create or update and evidence sources to inspect;
- processes that may start, their readiness checks, and stop method;
- snapshot, manifest verification, rollback, and residual-risk steps.

The user must explicitly approve that preview. Any added command, widened path, or new side effect requires a revised preview and fresh approval before proceeding.

## Execution (Validator)

1. Create a new timestamped `.ai-archive/<run-id>/` without replacing an existing archive.
2. Before any target mutation or side-effecting command, snapshot every existing approved write path and every path a command may mutate. Preserve file bytes, modes, directory entries, and symlinks without following them.
3. Write a manifest containing the run ID, target root, approved preview reference, every scoped path, its pre-run existence/type/metadata/digest, its snapshot location, and every approved command/process.
4. Verify the manifest inventory and snapshot bytes/metadata against the source. Stop with no target mutation if the snapshot is incomplete, escapes scope, or fails verification.
5. Start a run ledger. Record each command result, file state immediately before and after each write, created file/directory, and process ID started by this run. Refuse a write if its pre-write state differs from the verified snapshot or preceding ledger state.
6. Inspect the approved repository sources, identify the stack, landmarks, critical domains, commands, conventions, and invariants, then verify only the approved commands. Never guess results.
7. Write concise, source-linked context only to approved paths. Populate the overview, memory, indexes, and the previewed high-value feature/pattern docs; label gaps and unverified claims.
8. Stop every run-owned temporary process using its recorded PID and verify it exited. Perform all previewed cleanup and record the result.

## Verification and closeout

Validator checks that:

- the approved preview matches commands, writes, side effects, and cleanup;
- the archive and manifest were verified before target mutation;
- documented commands include actual result and useful timing evidence;
- claims and links resolve to inspected repository evidence;
- created and changed paths, command results, process cleanup, doc impact, memory impact, and residual risks are reported.

Validator returns review status `approve` or `needs changes`. Conductor alone records the route terminal state: `complete` after approval, `blocked` when remediation or approval is required, or `rolled back` after verified rollback.

## Rollback

Rollback uses the manifest and run ledger; it never deletes `.ai/docs/**` wholesale.

1. Stop only processes whose PIDs were recorded as started by this run.
2. Restore only pre-existing paths changed by this run from the verified snapshot.
3. Delete only files and directories recorded as created by this run, removing a directory only when it is empty after owned files are removed.
4. Before each reversal, require the current state to match the ledger's run-produced state. On concurrent or unowned changes, stop and report the path for manual resolution.
5. Verify restored metadata/digests, absence of owned creations, and process cleanup; retain the archive and final rollback record.

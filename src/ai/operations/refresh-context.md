# Operation: Refresh Context

Refresh existing Orchestra context from current repository evidence. This operation follows the `refresh-context` row in `.ai/agents/guides/routing.md`; it is not the `document` workflow and its preview is not a `change` plan.

## Intake and boundaries

Conductor records the refresh goals, target repository, stale context, exclusions, run constraints, permitted commands, and acceptable side effects. Refresh may write only paths named in its approved preview, normally existing `.ai/docs/**` and `.ai/MEMORY.md` plus its run archive.

- Preserve verified useful context; replace or archive content only when current evidence supports it.
- Do not mutate product/app files. Stop before those writes and route them to `change`.
- Do not run commands or perform broad writes while preparing the preview.
- Do not inspect historical plans under `.ai/plans/**`; they are execution artifacts, not refresh evidence.
- Do not follow symlinks outside the target repository or archive data outside approved scope.

## Approval gate

Before any command or broad write, Conductor presents one inline per-run preview containing:

- a timestamped UTC run ID (`YYYYMMDDTHHMMSSZ`, with a collision suffix when needed) and target root;
- exact commands, working directories, timeouts, expected outputs, and known side effects;
- normalized repository-relative read, write, move, archive, create, and cleanup paths;
- context sources, stale claims to re-check, intended restructures, and explicit exclusions;
- processes that may start, their readiness checks, and stop method;
- snapshot, manifest verification, rollback, and residual-risk steps.

The user must explicitly approve that preview. Any added command, widened path, or new side effect requires a revised preview and fresh approval before proceeding.

## Execution (Validator)

1. Create a new timestamped `.ai-archive/<run-id>/` without replacing an existing archive.
2. Before any target mutation or side-effecting command, snapshot every existing approved write/move path and every path a command may mutate. Preserve file bytes, modes, directory entries, and symlinks without following them.
3. Write a manifest containing the run ID, target root, approved preview reference, every scoped path, its pre-run existence/type/metadata/digest, its snapshot location, and every approved command/process.
4. Verify the manifest inventory and snapshot bytes/metadata against the source. Stop with no target mutation if the snapshot is incomplete, escapes scope, or fails verification.
5. Start a run ledger. Record each command result, file state immediately before and after each write/move, created file/directory, and process ID started by this run. Refuse a write if its pre-write state differs from the verified snapshot or preceding ledger state.
6. Inventory only current context and approved legacy sources. Compare claims with current code, dependencies, configuration, CI, and commands; never treat stale prose as proof.
7. Verify only approved commands, then update/restructure the previewed overview, memory, indexes, feature docs, and pattern docs. Keep verified content, remove or label disproven claims, repair links, and record remaining gaps.
8. Stop every run-owned temporary process using its recorded PID and verify it exited. Perform all previewed cleanup and record the result.

## Verification and closeout

Validator checks that:

- the approved preview matches commands, writes/moves, side effects, and cleanup;
- the archive and manifest were verified before target mutation;
- refreshed claims, commands, timings, conventions, invariants, and links have current evidence;
- valuable removed content is present in the declared archive and obsolete content is not presented as current;
- changed/created/moved paths, command results, process cleanup, doc impact, memory impact, and residual risks are reported.

Validator returns review status `approve` or `needs changes`. Conductor alone records `complete` after approval, `blocked` when remediation or approval is required, `rolled back` after verified rollback, or `promoted` when product/app work moves to `change`.

## Rollback

Rollback uses the manifest and run ledger; it never performs an unscoped restore.

1. Stop only processes whose PIDs were recorded as started by this run.
2. Restore only pre-existing paths changed or moved by this run from the verified snapshot.
3. Delete only files and directories recorded as created by this run, removing a directory only when it is empty after owned files are removed.
4. Before each reversal, require the current state to match the ledger's run-produced state. On concurrent or unowned changes, stop and report the path for manual resolution.
5. Verify restored metadata/digests, absence of owned creations, and process cleanup; retain the archive and final rollback record.

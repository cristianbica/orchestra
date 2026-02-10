# Pattern: Verification-First Workflow

## What it is

Orchestra treats verification as a required gate in every non-trivial workflow. The Builder runs the most relevant command available, and the Inspector checks that verification happened.

## How it shows up here

- `.ai/MEMORY.md` is where verified commands are documented.
- The template repo itself has no build/test suite; verification is typically limited to script inspection or manual checks.

## Why it matters

This keeps documentation honest: commands are only recorded once they are known to work in a given repo.

## See also

- [Memory](../../MEMORY.md) - Verified commands and conventions
- [workflows.md](../features/workflows.md) - Verification steps in each workflow

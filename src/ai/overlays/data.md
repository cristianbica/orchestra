# Overlay: data

Purpose:
- Protect data quality, traceability, and lifecycle expectations.
- Prevent integrity regressions during model and schema evolution.

When to apply:
- Data model changes, storage/transform logic, and reporting/metrics work.
- Migrations, backfills, indexing, and data-sensitive bug fixes.

Output focus:
- Data assumptions and invariants made explicit.
- Migration/backfill safety and rollback considerations.
- Verification for correctness and performance impact.

Decision prompts:
- What invariants must always hold before and after change?
- How will existing records be migrated or preserved safely?
- Which queries/paths are likely to regress in performance?

Quality checks:
- Data transitions are deterministic and reversible where possible.
- Integrity checks/constraints are aligned with business rules.
- Verification includes representative data scenarios.

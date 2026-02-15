# Database Code Review Guide

## Overview

Database-specific review checklist covering performance, migrations, security, data integrity, and ORM usage. Loaded when SQL files, migration paths, or database/ORM patterns are detected in the diff.

## Review Checklist

### Performance

- **What to check**: Database queries and operations are efficient and won't degrade under load.
- **Anti-patterns**:
  - **N+1 queries**: Looping over records and issuing a separate query per item instead of eager loading or joining
  - **Missing indexes**: Queries filtering or sorting on columns without supporting indexes
  - **Unbounded queries**: `SELECT` without `LIMIT` or pagination on tables that can grow large
  - **SELECT ***: Fetching all columns when only a subset is needed, especially on wide tables
  - **Full table scans**: Queries that cannot use indexes due to functions on columns, leading `%` wildcards, or `OR` conditions
  - **Repeated queries**: Same query executed multiple times in a single request when it could be cached or batched
  - **Unbatched row-by-row operations**: Inserting, updating, or deleting records one at a time in a loop instead of using bulk operations or chunking
- **Best practice**: Eager load associations. Add indexes for WHERE/ORDER BY columns. Always paginate unbounded listings. Select only needed columns. Use bulk operations for multiple records and chunk large datasets to avoid lock contention.

### Migrations & Schema Changes

- **What to check**: Schema changes are safe, reversible, and won't cause downtime.
- **Anti-patterns**:
  - **Destructive migrations**: Dropping columns or tables without confirming data is no longer needed
  - **Missing rollback**: Migration without a corresponding down/rollback method
  - **Locking operations on large tables**: Adding indexes without `CONCURRENTLY` (Postgres) or equivalent, renaming columns, or changing column types on high-traffic tables
  - **Non-nullable without default**: Adding a NOT NULL column to an existing table without a default value
  - **Data migrations mixed with schema**: Combining schema changes and data backfills in a single migration
  - **Missing foreign key constraints**: Relationships defined in ORM but not enforced at the database level
  - **Missing index on foreign key**: Foreign key column without a supporting index, causing slow joins and cascading operations
- **Best practice**: Make migrations reversible. Separate schema changes from data migrations. Use non-locking operations for large tables. Add NOT NULL columns in stages (add nullable → backfill → add constraint). Always add an index when creating a foreign key.

### Security

- **What to check**: Database interactions are safe from injection and unauthorized access.
- **Anti-patterns**:
  - **SQL injection**: String concatenation or interpolation in raw SQL instead of parameterized queries/bind variables
  - **Mass assignment**: Accepting user input directly into create/update without allowlisting attributes (e.g., missing `$fillable`/`strong_parameters`)
  - **Sensitive data exposure**: Storing passwords in plain text, logging full query results with PII, or including sensitive columns in default serialization
  - **Unfiltered bulk operations**: `DELETE` or `UPDATE` without `WHERE` clause, or with a `WHERE` clause built from user input
- **Best practice**: Always use parameterized queries. Allowlist assignable attributes explicitly. Never store secrets in plain text.

### Data Integrity

- **What to check**: Data remains consistent and correct under all conditions.
- **Anti-patterns**:
  - **Missing transactions**: Multi-step write operations that should be atomic but aren't wrapped in a transaction
  - **Missing uniqueness constraints**: Uniqueness enforced only in application code, not at the database level
  - **Missing validations**: Business rules enforced only in one layer (app or DB) instead of both
  - **Race conditions on writes**: Read-then-write patterns without optimistic locking or database-level constraints
  - **Orphaned records**: Deleting parent records without cascading or nullifying foreign keys
  - **Silent type coercion**: Inserting data that gets silently truncated or coerced by the database (e.g., string into integer column)
- **Best practice**: Wrap related writes in transactions. Enforce uniqueness and NOT NULL at the database level. Use optimistic locking for concurrent updates. Define cascade/nullify behavior on foreign keys.

### ORM Usage

- **What to check**: ORM features are used correctly and don't hide performance or correctness issues.
- **Anti-patterns**:
  - **Lazy loading in loops**: Accessing associations inside a loop without eager loading, causing N+1 queries
  - **Raw queries bypassing protections**: Using raw SQL that skips the ORM's built-in sanitization or scoping
  - **Improper relationship definitions**: Missing inverse associations, wrong foreign key names, or incorrect cardinality
  - **Callbacks with side effects**: Model callbacks (before_save, after_create) that trigger external calls, send emails, or enqueue jobs — making models hard to test and reason about
  - **Ignoring query results**: Not checking whether a save/update succeeded, especially when validations or constraints can fail
  - **Fat models**: Models with hundreds of lines mixing query scopes, business logic, and presentation concerns
- **Best practice**: Eager load associations explicitly. Keep raw SQL to a minimum and always parameterize. Define both sides of relationships. Move complex business logic out of model callbacks.

## Common Anti-patterns

| Anti-pattern | Severity | Signal |
|-------------|----------|--------|
| SQL injection via string interpolation | P0 | Security vulnerability |
| Mass assignment without attribute allowlist | P0 | Unauthorized data modification |
| Destructive migration without rollback | P1 | Irreversible data loss risk |
| N+1 queries in loops | P1 | Performance degradation |
| Missing transaction around multi-step writes | P1 | Data inconsistency |
| Missing database-level uniqueness constraint | P2 | Race condition on duplicates |
| SELECT * on wide or growing tables | P2 | Unnecessary resource usage |
| Unbounded query without LIMIT | P2 | Memory/performance risk at scale |
| Unbatched bulk operations on large datasets | P2 | Lock contention and timeouts |
| Model callbacks with external side effects | P3 | Testability and maintainability |

## Questions to Ask

- "What happens if this query runs against a table with millions of rows?"
- "Is this operation wrapped in a transaction? What if it partially fails?"
- "Are these constraints enforced at the database level, not just in application code?"
- "Is user input reaching this query safely through parameterized bindings?"
- "What happens to dependent records when this row is deleted?"
- "Are associations eager loaded, or will this trigger N+1 queries?"

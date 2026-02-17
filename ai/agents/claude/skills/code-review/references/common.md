# Common Code Review Guide

## Overview

General best practices applicable to all languages and frameworks. This guide is always loaded.

## Review Checklist

### Error Handling

- **What to check**: Every fallible operation (I/O, network, parsing, external calls) has appropriate error handling.
- **Anti-patterns**:
  - **Swallowed exceptions**: Empty catch blocks or catch-and-log-only without re-throwing or returning an error state
  - **Overly broad catch**: Catching base `Exception`/`Error` instead of specific types
  - **Missing error handling**: No try-catch around fallible operations, unhandled promise rejections, missing `.catch()`
  - **Error information leakage**: Stack traces, internal paths, or SQL queries exposed to end users
  - **Silent failures**: Functions return `null`/default on error with no logging or signal to callers
  - **Inconsistent error strategy**: Mix of exceptions, error codes, and result types in the same module
- **Best practice**: Catch at appropriate boundaries. Log with context (what failed, with which inputs). Propagate or handle gracefully. Users see friendly messages; developers see debug details.

### Boundary Conditions

- **What to check**: Edge cases are handled for all inputs and data flows.
- **Anti-patterns**:
  - **Null/undefined**: Accessing properties on potentially null objects without checks
  - **Empty collections**: Code assumes array has items (`arr[0]` without length check)
  - **Division by zero**: Missing guard before division or modulo
  - **Off-by-one**: Loop bounds, array slicing, pagination, fence-post errors
  - **Numeric overflow**: Large numbers exceeding safe integer range, unsigned/signed confusion
  - **Truthy/falsy confusion**: `if (value)` when `0`, `""`, or `false` are valid values
  - **String encoding**: Missing UTF-8 handling, locale-dependent comparisons, emoji/multi-byte issues
- **Best practice**: Validate at system boundaries. Handle the empty/null case explicitly. Use safe access patterns (optional chaining, guard clauses).

### Security

- **What to check**: Code and queries are safe from injection, data leaks, and unintended bulk operations.
- **Anti-patterns**:
  - **SQL injection**: String concatenation or interpolation in raw SQL instead of parameterized queries/bind variables
  - **Sensitive data exposure**: Storing passwords in plain text, logging full query results with PII, or including sensitive columns in default serialization
  - **Unfiltered bulk operations**: `DELETE` or `UPDATE` without `WHERE` clause, or with a `WHERE` clause built from unsanitized user input
- **Best practice**: Always use parameterized queries. Never store secrets in plain text. Allowlist serialized attributes explicitly. Audit logs for PII leakage.

### Performance

- **What to check**: Operations are bounded and don't degrade under load.
- **Anti-patterns**:
  - **Unbounded queries**: `SELECT` without `LIMIT` or pagination on tables that can grow large
  - **SELECT ***: Fetching all columns when only a subset is needed, especially on wide or growing tables
  - **Row-by-row operations in loops**: Inserting, updating, or deleting records one at a time in a loop instead of using bulk operations or chunking
  - **Repeated queries**: Same query executed multiple times in a single request when it could be cached or batched
- **Best practice**: Always paginate unbounded listings. Select only needed columns. Use bulk operations for multiple records and chunk large datasets.

### Concurrency & Race Conditions

- **What to check**: Shared state is accessed safely in concurrent or async contexts.
- **Anti-patterns**:
  - **Check-then-act (TOCTOU)**: Reading a value and acting on it without atomicity (e.g., check file exists then open)
  - **Shared mutable state**: Multiple threads/goroutines/coroutines modifying the same data without synchronization
  - **Race in async flows**: Multiple async operations modifying the same variable without coordination
  - **Deadlock risk**: Acquiring multiple locks in inconsistent order
  - **Missing transactions**: Multi-step write operations that should be atomic but aren't wrapped in a transaction
  - **Race conditions on writes**: Read-then-write patterns without optimistic locking or database-level constraints
- **Best practice**: Prefer immutable data. Use atomic operations or transactions for shared state. Keep critical sections small. Wrap related writes in transactions.

### Code Organization

- **What to check**: Code is well-structured and maintainable.
- **Anti-patterns**:
  - **SRP violation**: File/class with unrelated responsibilities or multiple reasons to change
  - **Long methods**: Functions with excessive length or multiple levels of nesting doing unrelated work
  - **Dead code**: Unreachable code, unused imports, commented-out blocks left behind
  - **Magic numbers/strings**: Hardcoded values without named constants or explanation
  - **Shotgun surgery**: One logical change requires edits across many unrelated files
  - **Speculative generality**: Abstractions, configs, or extension points for hypothetical future needs
  - **Copy-paste duplication**: Same logic repeated across multiple locations instead of being shared
- **Best practice**: Single responsibility per module. Name things by intent. Introduce abstractions only when needed. Delete dead code — version control remembers it.

### Naming & Readability

- **What to check**: Code communicates intent clearly to future readers.
- **Anti-patterns**:
  - **Misleading names**: Variable/function names that don't match behavior (e.g., `isValid` that also mutates state)
  - **Ambiguous abbreviations**: Names like `tmp`, `val`, `mgr`, `proc` that obscure meaning
  - **Boolean naming**: Boolean variables/parameters without `is`/`has`/`should` prefix, or double negatives (`!isNotEmpty`)
  - **Missing units in names**: Numeric variables without unit suffix (e.g., `timeout` instead of `timeoutMs`, `size` instead of `sizeBytes`, `delay` instead of `delaySeconds`)
  - **Inconsistent conventions**: Mixing camelCase/snake_case, or different naming patterns for similar concepts
  - **Misleading comments**: Comments that describe what code *used to do* rather than what it *does now*
- **Best practice**: Choose names that make comments unnecessary. Follow the project's existing conventions. A good name is the best documentation.

## Common Anti-patterns

| Anti-pattern | Severity | Signal |
|-------------|----------|--------|
| SQL injection via string interpolation | P0 | Security vulnerability |
| Swallowed exceptions hiding failures | P1 | Silent bugs in production |
| Check-then-act without atomicity | P1 | Race condition |
| Missing transactions around multi-step writes | P1 | Data inconsistency |
| Missing null/empty checks at boundaries | P2 | Runtime errors |
| Unbounded queries without LIMIT | P2 | Memory/performance risk at scale |
| Dead code / unused imports left behind | P2 | Maintainability debt |
| Copy-paste duplication across files | P2 | Maintenance burden |
| Magic numbers without named constants | P3 | Readability |
| Misleading variable/function names | P3 | Cognitive overhead |

## Questions to Ask

- "What happens when this operation fails?"
- "What if this input is null/undefined/empty?"
- "Is there enough context to debug this error in production?"
- "What's the valid range and maximum size for this input?"
- "Can this code run concurrently? If so, is shared state protected?"
- "Is user input reaching this query safely through parameterized bindings?"
- "Is this operation wrapped in a transaction? What if it partially fails?"

# Common Code Review Guide

## Overview

General best practices applicable to all languages and frameworks. This guide is always loaded.

## Review Checklist

### Error Handling

- **What to check**: Every fallible operation (I/O, network, parsing, external calls) has appropriate error handling.
- **Anti-patterns**:
  - Swallowed exceptions: empty catch blocks or catch-and-log-only
  - Overly broad catch: catching base `Exception`/`Error` instead of specific types
  - Missing error handling: no try-catch around fallible operations
  - Error information leakage: stack traces or internal details exposed to users
  - Async errors: unhandled promise rejections, missing `.catch()`, no error boundaries
- **Best practice**: Catch at appropriate boundaries, log with context, propagate or handle gracefully. Users see friendly messages; developers see debug details.

### Boundary Conditions

- **What to check**: Edge cases are handled.
- **Anti-patterns**:
  - **Null/undefined**: Accessing properties on potentially null objects without checks
  - **Empty collections**: Code assumes array has items (`arr[0]` without length check)
  - **Division by zero**: Missing check before division
  - **Off-by-one**: Loop bounds, array slicing, pagination
  - **Numeric overflow**: Large numbers exceeding safe integer range
  - **Truthy/falsy confusion**: `if (value)` when `0` or `""` are valid values
- **Best practice**: Validate at boundaries. Handle the empty case explicitly. Use safe access patterns.

### Code Organization

- **What to check**: Code is well-structured and maintainable.
- **Anti-patterns**:
  - **SRP violation**: File/class with unrelated responsibilities or multiple reasons to change
  - **Long methods**: Functions > 30 lines with multiple levels of nesting
  - **Dead code**: Unreachable or never-called code
  - **Magic numbers/strings**: Hardcoded values without named constants
  - **Feature envy**: Method uses more data from another class than its own
  - **Shotgun surgery**: One change requires edits across many unrelated files
  - **Speculative generality**: Abstractions for hypothetical future needs
- **Best practice**: Single responsibility per module. Name things by intent. Introduce abstractions only when needed. Delete dead code.

## Questions to Ask

- "What happens when this operation fails?"
- "What if this is null/undefined/empty?"
- "Is there enough context to debug this error?"
- "What's the valid range for this input?"

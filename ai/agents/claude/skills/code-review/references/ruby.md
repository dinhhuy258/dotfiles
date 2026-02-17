# Ruby Code Review Guide

## Overview

General Ruby review checklist covering exception handling, idiomatic patterns, method design, performance, thread safety, and metaprogramming. Loaded when `.rb` files are detected in the diff.

## Review Checklist

### Exception Handling

- **What to check**: Exceptions are rescued specifically and handled at appropriate boundaries.
- **Anti-patterns**:
  - **Bare `rescue`**: Using `rescue` without specifying an exception class (catches `StandardError` silently)
  - **Rescuing `Exception`**: Catching `Exception` instead of `StandardError`, which swallows `SignalException`, `NoMemoryError`, and `SystemExit`
  - **Rescue for control flow**: Using exceptions for expected conditions (e.g., `rescue ActiveRecord::RecordNotFound` instead of `find_by`)
  - **Missing `ensure`**: Resources (files, connections) opened without `ensure` or block form to guarantee cleanup
  - **Bare `retry` without limit**: `retry` in a rescue block without a counter, causing infinite loops on persistent errors
- **Best practice**: Rescue specific exception classes. Use block forms (`File.open { |f| ... }`) for automatic cleanup. Limit retries. Let unexpected exceptions propagate.

### Idiomatic Ruby

- **What to check**: Code follows Ruby conventions and uses the language effectively.
- **Anti-patterns**:
  - **Explicit `return` in final expression**: Using `return` when the last expression is already the return value
  - **`for` loops**: Using `for x in collection` instead of `collection.each`
  - **Ternary abuse**: Nested ternary operators or ternaries with side effects
  - **`if !condition`**: Using `if !x` instead of `unless x` (but don't use `unless` with `else` or complex conditions)
  - **Mutable string literals**: Missing `# frozen_string_literal: true` magic comment when strings are not mutated
  - **String keys in hashes**: Using `"key"` instead of `:key` for internal hashes
  - **`self.` when unnecessary**: Using `self.method` for reads when `self` is not required
  - **Manual nil checking**: Using `if x != nil` instead of `unless x.nil?` or safe navigation (`&.`)
- **Best practice**: Follow Ruby's principle of least surprise. Use guard clauses for early returns. Prefer symbols for internal identifiers. Use `frozen_string_literal: true`.

### Method Design & Visibility

- **What to check**: Methods are well-designed with clear contracts and appropriate access control.
- **Anti-patterns**:
  - **Everything public**: All methods left public when only a few are part of the external API
  - **`protected` misuse**: Using `protected` when `private` is intended (protected allows access from same-class instances)
  - **Long parameter lists**: Methods with more than 3 positional parameters instead of keyword arguments or parameter objects
  - **Unclear return values**: Methods that sometimes return a value and sometimes return `nil` without clear documentation
  - **Bang method misuse**: `!` methods that don't raise on failure, or non-bang methods that mutate state
- **Best practice**: Default to `private`. Use keyword arguments for optional parameters. Methods should do one thing. Bang methods should raise on failure.

### Performance

- **What to check**: Code avoids common Ruby performance pitfalls.
- **Anti-patterns**:
  - **Redundant enumerable chains**: Chaining multiple enumerable methods allocates throwaway arrays between each step. Combine into a single pass instead:
    - `map` + `compact` → `filter_map`
    - `map` + `select` → `filter_map`
    - `map` + `flatten` → `flat_map`
    - `select` + `map` → `each_with_object`
  - **String concatenation in loops**: Using `+=` to build strings instead of `<<` or array `join`
  - **Unnecessary object allocation**: Creating objects in hot loops that could be reused or pre-allocated (e.g., `Regexp.new` inside a loop)
  - **Missing memoization**: Expensive computations or I/O repeated across calls when the result is deterministic (`@result ||= compute`)
  - **`include?` on large arrays**: Using `Array#include?` for membership checks on large collections instead of `Set`
  - **Loading entire collections**: Using `to_a` or `map` on large datasets when lazy enumeration or batching would work
- **Best practice**: Use `<<` for string building. Prefer `Set` for membership checks. Memoize expensive calls. Use `Enumerable#lazy` for large chains.

### Thread Safety & Concurrency

- **What to check**: Code is safe in multi-threaded environments (Puma, Sidekiq).
- **Anti-patterns**:
  - **Mutable class/module state**: Class variables (`@@var`) or class-level instance variables modified at runtime without synchronization
  - **`||=` race condition**: Using `||=` for lazy initialization of shared state — not atomic in MRI for complex expressions
  - **Global mutable state**: Modifying `$global` variables, `ENV`, or shared constants at runtime
  - **Thread-unsafe libraries**: Using gems or stdlib classes that aren't thread-safe without synchronization (e.g., `Net::HTTP` connection reuse)
- **Best practice**: Prefer request-local or thread-local state. Use `Mutex` or `Concurrent::` primitives for shared mutable state. Treat class state as read-only after boot.

### Metaprogramming

- **What to check**: No metaprogramming is used. Flag any occurrence as a P1 violation.
- **Rule**: Metaprogramming must be avoided entirely — `method_missing`, `define_method`, `eval`, `class_eval`, `instance_eval`, `send`, and monkey-patching are all prohibited. There are no acceptable use cases in application code. Always replace with explicit methods, delegation, or composition.
- **Best practice**: Write explicit, boring code. If a pattern seems to need metaprogramming, redesign the approach instead.

## Common Anti-patterns

| Anti-pattern | Severity | Signal |
|-------------|----------|--------|
| Bare `retry` without limit | P1 | Infinite loop on persistent errors |
| Any metaprogramming (`eval`, `method_missing`, `define_method`, `send`, monkey-patching) | P1 | Prohibited — use explicit code |
| Mutable class/module state without synchronization | P1 | Thread safety in Puma/Sidekiq |
| String concatenation with `+=` in loops | P2 | O(n^2) memory allocation |
| Missing `frozen_string_literal: true` | P3 | Unnecessary string allocations |
| Explicit `return` in final expression | P3 | Non-idiomatic Ruby |

## Questions to Ask

- "Is this `rescue` clause catching the most specific exception possible?"
- "Can this method be `private`? Who needs to call it from outside?"
- "Is this memoization safe in a multi-threaded context?"
- "Could this be written with explicit methods instead of metaprogramming?"
- "What happens when this operation fails? Is the error recoverable?"
- "Is this code safe to run concurrently in Puma or Sidekiq?"

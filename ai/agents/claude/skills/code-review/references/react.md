# React Code Review Guide

## Overview

React-specific review checklist covering hooks, component design, rendering, and security. Loaded when `.jsx`/`.tsx` files or React patterns are detected in the diff.

## Review Checklist

### Hooks

- **What to check**: Hooks follow React's rules and are used correctly.
- **Anti-patterns**:
  - **Missing dependencies**: `useEffect`, `useMemo`, `useCallback` with incomplete dependency arrays
  - **Stale closures**: Using values inside effects/callbacks that aren't in the dependency array
  - **Hooks in conditionals/loops**: Calling hooks inside `if`, `for`, or nested functions
  - **Over-use of useEffect**: Using effects for derived state that could be computed during render
  - **Missing cleanup**: Effects that set up subscriptions, timers, or listeners without returning a cleanup function
- **Best practice**: Keep dependency arrays complete. Derive state during render when possible. Always clean up side effects.

### Component Design

- **What to check**: Components are well-structured and follow React patterns.
- **Anti-patterns**:
  - **Prop drilling**: Passing props through many intermediate components that don't use them
  - **Giant components**: Components > 200 lines doing too many things
  - **Inline object/function creation**: Creating new objects or functions in JSX props (causes unnecessary re-renders)
  - **Missing key prop**: Lists rendered without stable, unique keys
  - **Index as key**: Using array index as key for dynamic lists where items can be reordered/deleted
  - **Boolean trap**: Components with multiple boolean props that are hard to understand
- **Best practice**: Break large components into focused pieces. Memoize expensive computations. Use stable, unique keys for lists.

### State Management

- **What to check**: State is managed correctly and efficiently.
- **Anti-patterns**:
  - **Redundant state**: State that can be derived from other state or props
  - **State synchronization**: Using effects to sync two pieces of state
  - **Storing derived data**: Keeping computed values in state instead of computing during render
  - **Missing controlled/uncontrolled distinction**: Mixing controlled and uncontrolled inputs
  - **State updates during render**: Calling setState during rendering without guards
- **Best practice**: Minimize state. Compute derived values during render. Lift state up only when needed.

### Rendering & Performance

- **What to check**: No unnecessary re-renders or performance issues.
- **Anti-patterns**:
  - **Missing memoization**: Expensive computations re-running on every render
  - **Unnecessary re-renders**: Parent re-renders causing all children to re-render
  - **Large component trees**: Not splitting code with `React.lazy` and `Suspense`
  - **Unmemoized context value**: Context provider value changing on every render
- **Best practice**: Use `React.memo`, `useMemo`, `useCallback` where profiling shows benefit. Don't optimize prematurely.

### Security

- **What to check**: No XSS or injection vulnerabilities.
- **Anti-patterns**:
  - **`dangerouslySetInnerHTML`**: Using without sanitization
  - **Unsafe URL handling**: User-provided URLs in `href` or `src` without validation (e.g., `javascript:` protocol)
  - **Eval-like patterns**: `eval()`, `Function()`, or `new Function()` with user input
- **Best practice**: Never use `dangerouslySetInnerHTML` with unsanitized input. Validate and sanitize all user-provided URLs.

### Effects & Lifecycle

- **What to check**: Effects are used correctly and don't cause issues.
- **Anti-patterns**:
  - **Race conditions in effects**: Async operations without cleanup/cancellation
  - **Infinite loops**: Effects that trigger their own dependencies
  - **Memory leaks**: Setting state on unmounted components
  - **Missing error boundaries**: No error boundary wrapping components that can throw
- **Best practice**: Use AbortController for async effects. Add error boundaries around fallible UI sections.

## Common Anti-patterns

| Anti-pattern | Severity | Signal |
|-------------|----------|--------|
| `dangerouslySetInnerHTML` without sanitization | P0 | XSS vulnerability |
| Missing effect cleanup (timers, subscriptions) | P1 | Memory leak |
| Hooks inside conditionals | P1 | React rules violation |
| Missing/wrong dependency array | P1 | Stale data bugs |
| Index as key in dynamic list | P2 | UI bugs on reorder/delete |
| Inline objects/functions in JSX props | P3 | Unnecessary re-renders |

## Questions to Ask

- "Will this effect clean up properly on unmount?"
- "Is this dependency array complete?"
- "Could this state be derived instead of stored?"
- "What happens if the async operation completes after unmount?"
- "Is this key stable and unique across re-renders?"

# [System Change] Design

## Overview

What is changing and why. (2–4 sentences)

## Current State

How the system works today. Include a diagram.

## Proposed State

How the system will work after the change. Include a diagram.

## Component Mapping

| Component  | Current          | Proposed           | Notes              |
| ---------- | ---------------- | ------------------ | ------------------ |
| `module-a` | Monolith handler | Standalone service | Extracted, new API |

## Design Decisions

For each non-obvious choice:

- Decision
- Alternatives considered
- Rationale
- Risks and mitigations

## Data Flow

How data moves through the new architecture. Sequence or flow diagram.

## Downstream Impact

| Consumer / Team | Change Required     |
| --------------- | ------------------- |
| `project-name`  | What needs updating |

## Migration Plan

### Execution Order

| Step | Action | Dependencies |
| ---- | ------ | ------------ |
| 1    | ...    | ...          |

### Rollback Plan

How to revert if things go wrong.

## Edge Cases & Risks

| Risk | Impact | Mitigation |
| ---- | ------ | ---------- |
| ...  | ...    | ...        |

## Monitoring & Observability

Key metrics, dashboards, and alerts for the new architecture.

## Open Questions

- [ ] Question 1
- [ ] Question 2

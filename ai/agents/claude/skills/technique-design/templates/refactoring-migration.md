# [Migration/Refactoring] Design

## Overview

What is being refactored or migrated, and why now. (2–4 sentences)

## Motivation

- Pain points with current approach
- Trigger for this work (incident, scaling limit, deprecation, etc.)

## Resource Mapping

| Source     | Destination | Notes                        |
| ---------- | ----------- | ---------------------------- |
| `old/path` | `new/path`  | Renamed, split, merged, etc. |

## Execution Order

| Step | Action | Scope | Reversible? |
| ---- | ------ | ----- | ----------- |
| 1    | ...    | ...   | Yes/No      |

## Compatibility

How backward compatibility is maintained during the transition (if applicable).

## Design Decisions

Key choices and rationale — especially around sequencing and compatibility.

## Downstream Impact

| Consumer / Team | Change Required     |
| --------------- | ------------------- |
| `project-name`  | What needs updating |

## Verification

How to confirm each step succeeded before proceeding to the next.

## Risks

| Risk | Impact | Mitigation |
| ---- | ------ | ---------- |
| ...  | ...    | ...        |

## Open Questions

- [ ] Question 1
- [ ] Question 2

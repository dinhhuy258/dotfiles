---
name: writing-plans
description: Turn a design document from brainstorming into a concrete implementation plan. Read-only — no code changes.
allowed-tools: Read, Write(docs/plans/*), Grep, Glob, Bash(git:*, tree:*, wc:*), AskUserQuestion, Task, TaskCreate, TaskUpdate, TaskList
---

# Writing Plans

## Overview

You are a Lead Architect turning a design document into a step-by-step implementation plan for a developer who is technically capable but completely new to this codebase. Your goal is to eliminate ambiguity.

**Announce at start:** "I'm using the writing-plans skill to create the implementation plan."

**Core Philosophies:**
- **TDD First** — Every feature starts with a failing test.
- **Micro-Steps** — Each step is one small action with a clear done state.
- **Zero-Assumption** — Provide exact file paths, complete code snippets, and exact CLI commands.
- **DRY / YAGNI** — Reuse existing patterns. Don't plan for hypothetical requirements.

## Workflow

1. **Read the design document** — Find the relevant design doc in `docs/plans/` and use it as the basis for the plan.
2. **Scan the codebase** — Silently read the files and modules referenced in the design to understand current state, existing patterns, and exact file paths.
3. **Write the plan** — Present it to the user for review before saving.
4. **Save** — Write the final plan to `docs/plans/YYYY-MM-DD-<feature-name>-plan.md`.

## Plan Document Structure

### Header

**Every plan MUST start with this header:**

```markdown
# [Feature Name] Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use executing-plans to implement this plan task-by-task.

**Goal:** [One sentence describing what this builds]

**Architecture:** [2-3 sentences about approach]

**Tech Stack:** [Key technologies/libraries]

---
```

### Tasks

Tasks are ordered sequentially.

```markdown
### Task N: [Component Name]

**Files:**
- Create: `exact/path/to/file`
- Modify: `exact/path/to/existing:line_range`
- Test: `tests/exact/path/to/test`

**Step 1: Write the failing test**

[Complete test code]

**Step 2: Run test to verify it fails**

Run: `[exact test command]`
Expected: FAIL with "[expected error]"

**Step 3: Write the implementation**

[Complete implementation code]

**Step 4: Run test to verify it passes**

Run: `[exact test command]`
Expected: PASS
```

Adapt the step format to the task — not every task follows the TDD cycle. For non-test tasks, use whatever structure makes the steps clear. But always provide complete code.

## Handoff to Execution

After saving the plan, ask the user: *"Ready to execute the plan?"*

If yes, launch the `plan-executor` agent with the path to the saved plan file.

## Remember

- Exact file paths always
- Complete code in plan (not "add validation")
- Exact commands with expected output
- DRY, YAGNI, TDD

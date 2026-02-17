---
name: quick-plan
description: Lightweight design-and-implement skill for small-to-medium tasks. Collapses brainstorming + writing-plans + executing-plans into one session.
user-invocable: true
disable-model-invocation: true
allowed-tools: Read, Edit, Write, Grep, Glob, Bash, AskUserQuestion, WebSearch, mcp__context7__resolve-library-id, mcp__context7__query-docs, mcp__sequential-thinking__sequentialthinking, TaskCreate, TaskUpdate, TaskList
---

# Quick Plan

Design and implement small-to-medium tasks in a single session — no intermediate files, no skill handoffs.

**Announce at start:** "I'm using the quick-plan skill to design and implement this task."

## Core Principles

**Design philosophy:**
- **YAGNI** — Push back on speculative features. If there's no concrete need today, leave it out.
- **KISS** — Bias toward the simplest solution that works. Challenge unnecessary complexity.
- **DRY** — Reuse existing patterns and modules in the codebase before proposing new ones.

**Conversation style:**
- **One question at a time** — Never ask multiple questions in a single message.
- **Multiple choice when possible** — Always include an "Other" escape hatch so the user can freely share their own ideas.
- **Explore before committing** — Always present 2–3 approaches before settling on one.
- **Incremental validation** — Get user approval before moving between phases.
- **Constructive pushback** — If the user picks an approach with significant risks they may not have considered, flag them once. If the user confirms their choice, proceed with full commitment to making that option succeed.

## Workflow

### Phase 1: Context & Discovery

**Step A — Read the codebase first:**

Tell the user *"Let me explore the relevant parts of the codebase first."* then do the following silently (don't narrate each file read):

1. **Quick scan** — Use Glob/Grep/Read to understand the relevant area: project structure, key modules, existing patterns.
2. **Existing designs** — Check for existing design documents or past plans in `docs/plans/` to avoid re-treading covered ground.
3. **Locate the target** — Identify where the change belongs. If the location or integration flow is unclear, this becomes your **first question** to the user.

**Step B — Scope the problem:**

If the task is too broad or complex for a single session, suggest escalating to `/brainstorming` for the full design flow. Indicators of complexity:
- Requires significant architectural decisions with long-term implications
- Has unclear requirements that need extended discovery

**Step C — Ask questions to fill the gaps:**

Ask questions **one at a time** to deeply understand the **purpose**, **constraints**, and **success criteria**.

Keep going until you can clearly articulate: **what** we're building, **why** it matters, and **where** it fits in the existing system.

### Phase 2: Propose Options & Trade-offs

Present 2–3 viable approaches. **Lead with your recommendation and why.**

For each option, use this format:

```markdown
## Option X: [Name] (Recommended — if applicable)
**Approach**: [Brief description]
**When to choose**: [One-liner on what makes this the right pick]

**Pros**:
- [Advantage 1]
- [Advantage 2]

**Cons**:
- [Disadvantage 1]
- [Disadvantage 2]

**Effort**: [Low/Medium/High]
**Risk**: [Low/Medium/High]
**Fits existing patterns**: [Yes/Partially/No]
```

After listing all options, include a **quick comparison table**:

```markdown
| Criteria      | Option A [Name] | Option B [Name] | Option C [Name] |
| ------------- | --------------- | --------------- | --------------- |
| Effort        | Low             | Medium          | High            |
| Risk          | Medium          | Low             | Low             |
| Fits patterns | Yes             | Partially       | No              |
```

Wait for the user to pick one before moving to Phase 3.

### Phase 3: Inline Plan & Execute

**Step A — Present the plan:**

Present a concise implementation plan directly in the conversation. No file is saved. Format:

```markdown
## Implementation Plan

### 1. [Action description]
[Brief description of what changes and why]

### 2. [Action description]
[Brief description of what changes and why]

### 3. Verify
[How to confirm it works — tests, commands, etc.]
```

Wait for user approval before writing any code.

**Step B — Implement:**

Execute the plan directly:
1. Make the code changes
2. Run verifications (tests, lint, build — whatever is relevant)
3. Report results

If you hit a blocker during implementation, stop and ask rather than guessing.

## Research

- Use **WebSearch** for general research: evaluating approaches, exploring best practices, or comparing established patterns.
- Use **Context7** for library-specific documentation: version-specific APIs, configuration options, or implementation examples.

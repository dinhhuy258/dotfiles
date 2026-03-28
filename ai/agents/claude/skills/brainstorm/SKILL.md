---
name: brainstorm
description: Collaborative brainstorm for architecture decisions, feature design, or any problem with multiple viable approaches. Read-only — no code changes.
user-invocable: true
disable-model-invocation: true
allowed-tools: Read, Write(docs/plans/*), Grep, Glob, Bash(git:*, tree:*, wc:*), AskUserQuestion, WebSearch, mcp__context7__resolve-library-id, mcp__context7__query-docs, mcp__sequential-thinking__sequentialthinking, TaskCreate, TaskUpdate, TaskList
---

# Brainstorm

Help turn ideas into fully formed designs through natural collaborative dialogue.

## Core Principles

**Design philosophy:**
- **YAGNI** — Push back on speculative features. If there's no concrete need today, leave it out.
- **KISS** — Bias toward the simplest solution that works. Challenge unnecessary complexity.
- **DRY** — Reuse existing patterns and modules in the codebase before proposing new ones.
- **Defensive Engineering** — Assume failures are possible. Right-size risk analysis to the feature’s complexity. Surface the most likely bottlenecks, silent failures, and edge cases for this domain.

**Conversation style:**
- **One question at a time** — Never ask multiple questions in a single message.
- **Multiple choice when possible** — Easier to answer than open-ended when possible
- **Explore before committing** — Always present 2–4 approaches before settling on one.
- **Incremental validation** — Present the design one logical section at a time. Get a thumbs-up before moving on.
- **Constructive pushback** — If the user picks an approach with significant risks they may not have considered, flag them once. If the user confirms their choice, proceed with full commitment to making that option succeed.

**Boundary:**
- **No code changes** — This is a design-only session. If the user requests code changes, remind them and offer to switch to an implementation workflow.

## Workflow

### Phase 1: Context & Discovery

**Step A — Read the codebase first:**

Tell the user *"Let me explore the relevant parts of the codebase first."* then do the following silently (don't narrate each file read):

1. **Quick scan** — Use Glob/Grep/Read to understand the relevant area: project structure, key modules, existing patterns (sync vs async, DB layer, error handling, auth).
2. **Locate the target** — Identify where the change belongs. If the location or integration flow is unclear, this becomes your **first question** to the user.

**Step B — Scope the problem:**

If the topic is too broad to design in a single session, propose breaking it into scoped sub-problems and pick one to start with.

**Step C — Then ask questions to fill the gaps:**

Use the **AskUserQuestion** tool to ask questions **one at a time** to deeply understand the **purpose**, **constraints**, and **success criteria**.

Keep going until you can clearly articulate: **what** we're building, **why** it matters, and **where** it fits in the existing system.

### Phase 2: Propose Options & Trade-offs

Present 2–4 viable approaches. **Lead with your recommendation and why.**

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

After listing all options, include a **quick comparison table** to make trade-offs visible at a glance:

```markdown
| Criteria      | Option A [Name] | Option B [Name] | Option C [Name] |
| ------------- | --------------- | --------------- | ----------- |
| Effort        | Low             | Medium          | High        |
| Risk          | Medium          | Low             | Low         |
| Fits patterns | Yes             | Partially       | No          |
```

Wait for the user to pick one before moving to Phase 3.

### Phase 3: Iterative Design

For the chosen approach, present the design **one section at a time**. Wait for validation after each before continuing.

Pick the sections that are relevant to the problem — not every design needs all of them:

- **Logic flow & architecture** — How data/control flows through the system. Include a simple diagram if it helps (mermaid or ASCII).
- **Component & file changes** — What gets created, modified, or removed. Be specific about file paths.
- **Edge cases, error handling & security** — What can go wrong. How we handle it.
- **Testing strategy** — What to test and at which level (unit, integration, e2e).

## Handoff

When the design is validated:

1. **Save the design:**
   Write the final design to `docs/plans/YYYY-MM-DD-<topic>-design.md` (e.g., `2026-02-14-auth-redesign-design.md`). Create the `docs/plans/` directory if it doesn't exist.

2. **Bridge to implementation:**
   Ask: *"Ready to create a plan?"*
   Use the `plan` skill to generate a detailed implementation plan.

## Research

- Use **WebSearch** for general research: evaluating approaches, exploring best practices, or comparing established patterns.
- Use **Context7** for library-specific documentation: version-specific APIs, configuration options, or implementation examples.

---
name: technique-design
description: Write a technical design document for a feature, system, or architecture change. Read-only — no code changes.
user-invocable: true
disable-model-invocation: true
allowed-tools: Read, Write(docs/designs/*), Grep, Glob, Bash(git:*, tree:*, wc:*), AskUserQuestion, WebSearch, mcp__context7__resolve-library-id, mcp__context7__query-docs, mcp__sequential-thinking__sequentialthinking, TaskCreate, TaskUpdate, TaskList
---

# Technical Design

Write clear, comprehensive technical design documents that serve as the single source of truth for implementation.

## Core Principles

**Design philosophy:**
- **YAGNI** — Design only for known requirements. Call out future considerations separately without designing for them.
- **KISS** — Favor the simplest solution that meets the requirements. Justify any added complexity.
- **DRY** — Reuse existing patterns, modules, and infrastructure in the codebase before proposing new ones.
- **Defensive Engineering** — Surface failure modes, edge cases, and operational risks proportional to the feature's complexity.

**Conversation style:**
- **Always use AskUserQuestion** — Use the **AskUserQuestion** tool with `Other` options for all questions to the user.
- **One question at a time** — Never ask multiple questions in a single message.
- **Multiple choice when possible** — Always include a recommended option (marked as such) and an "Other" escape hatch so the user can freely share their own ideas.
- **Explore before committing** — Always present 2–4 approaches before settling on one.
- **Incremental validation** — Present the design one logical section at a time. Get a thumbs-up before moving on.
- **Constructive pushback** — If the user picks an approach with significant risks they may not have considered, flag them once. If the user confirms their choice, proceed with full commitment to making that option succeed.

**Writing style:**
- **Audience** — Write for a developer who is technically capable but unfamiliar with this area of the codebase.
- **Concrete over abstract** — Use exact file paths, real data examples, and specific technology names. Avoid vague terms like "a service" or "some module."
- **Diagrams over prose** — Use mermaid or ASCII diagrams for flows, architecture, and data models. A diagram is worth a thousand words.
- **Decision records** — For every non-obvious choice, document what was considered and why the chosen approach won.

**Boundary:**
- **No code changes** — This skill produces design documents only. If the user requests implementation, remind them and offer to switch to an implementation workflow.

## Workflow

### Phase 1: Context Gathering

**Step A — Explore the codebase:**

Tell the user *"Let me explore the relevant parts of the codebase first."* then silently:

1. **Quick scan** — Use Glob/Grep/Read to understand the relevant area: project structure, key modules, existing patterns, dependencies.
2. **Locate the target** — Identify where the change belongs and what it touches. If unclear, ask the user.

**Step B — Clarify scope:**

Ask questions **one at a time** to understand:
- **What** is being built or changed
- **Why** it's needed (problem statement, motivation)
- **Who** are the consumers/users
- **Constraints** (performance, compatibility, timeline, etc.)

Keep going until you can write a clear problem statement and list of requirements.

### Phase 2: Write the Design Document

Write the document section by section, presenting **one section at a time** for user validation before continuing.

Pick the sections that fit the problem — not every design needs all of them. Adapt the structure to serve the content, not the other way around. Use the section catalog below as a menu, not a checklist.

### Phase 3: Review & Save

1. Present the complete document for final review.
2. Save to `docs/designs/YYYY-MM-DD-<topic>.md`.

## Document Structures

Different designs call for different structures. Pick the type that best fits the problem, then **Read only the chosen template** — do not load all templates.

| Type | When to use | Template |
|------|-------------|----------|
| Feature Design | New features, capabilities, or user-facing changes | `templates/feature-design.md` |
| Architecture / System Change | Restructuring systems, new infrastructure, cross-cutting changes | `templates/architecture-change.md` |
| Refactoring / Migration | Code reorganization, dependency upgrades, data migrations, tech debt | `templates/refactoring-migration.md` |
| API / Interface Design | New or modified API, protocol, or contract between systems | `templates/api-design.md` |
| Decision Record | Small focused decisions — library choice, naming convention, config change | `templates/decision-record.md` |

**How to use:** After determining the design type during Phase 1, Read the matching template file (paths are relative to this skill's directory). Adapt the structure — rename, merge, drop, or add sections as needed.

## Research

- Use **WebSearch** for general research: evaluating approaches, exploring best practices, or comparing patterns.
- Use **Context7** for library-specific documentation: version-specific APIs, configuration options, or implementation examples.

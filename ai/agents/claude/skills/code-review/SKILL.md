---
name: code-review
description: Review GitHub Pull Requests with technology-aware reference guides
user-invocable: true
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, Bash(gh:*, git:*)
---

# Code Review

Review a GitHub Pull Request with structured, technology-aware analysis.

## Arguments

This skill accepts one argument: a **PR number** (e.g., `123`) or a **PR URL** (e.g., `https://github.com/owner/repo/pull/123`).

- If a URL is provided, extract the PR number from it.
- If no argument is provided, ask the user for a PR number.

## Workflow

### 1) Fetch PR context

Run the following commands to gather context:

- `gh pr view <number>` — Get PR title, description, author, and base branch.
- `gh pr diff <number>` — Get the full diff against the base branch.
- `gh pr diff <number> --name-only` — Get the list of changed file names.

If the diff is very large (>1000 lines), summarize by file first, then review in batches grouped by module or directory. Output findings incrementally per batch.

### 2) Detect technologies

Scan the changed file names and diff content to determine which technologies are present. Use the detection table below to decide which reference guides to load.

**Detection Table:**

| Signal | Technology | Reference File |
|--------|-----------|----------------|
| Always | Common | `references/common.md` |
| Changed files with `.jsx`, `.tsx` extensions | React | `references/react.md` |
| Changed files with `.rb` extension | Ruby | `references/ruby.md` |
| Changed files with `.sql` extension; OR file paths contain `migrations/`, `models/`; OR diff contains database/ORM patterns | Database | `references/database.md` |

**Rules:**
- Always load `references/common.md`.
- Load a technology-specific reference only if its signals are detected.
- Multiple technology references can be loaded simultaneously.

### 3) Load reference guides

Read each matched reference file from the `references/` directory. These contain the review checklists and anti-patterns to check against.

### 4) Analyze the diff

Review every changed file against all loaded reference guides. If context around a change is unclear from the diff alone, read the full source file to understand the surrounding code before flagging issues.

For each issue found:
- Identify the exact file and line number.
- Classify severity using the table below.
- Provide a clear description and suggested fix.

Focus on **real issues** that affect correctness, security, performance, or maintainability. Do not flag stylistic preferences or nitpicks unless they indicate a deeper problem.

**Severity Definitions:**

| Level | Name | Description | Action |
|-------|------|-------------|--------|
| P0 | Critical | Security vulnerability, data loss risk, correctness bug | Must block merge |
| P1 | High | Logic error, significant design violation, performance regression | Should fix before merge |
| P2 | Medium | Code smell, maintainability concern, missing edge case handling | Fix in this PR or create follow-up |
| P3 | Low | Style, naming, minor suggestion | Optional improvement |

### 5) Output the review

Structure the review as follows:

```markdown
## Code Review: PR #<number> — <title>

**Files reviewed**: X files, Y lines changed
**Technologies detected**: [Common, React, ...]
**References loaded**: [common.md, react.md, ...]
**Overall assessment**: APPROVE | REQUEST_CHANGES | COMMENT

---

## Findings

### P0 — Critical
(none or list)

### P1 — High
- **[file:line]** Brief title
  - Description of issue
  - Suggested fix

### P2 — Medium
...

### P3 — Low
...

---

## Additional Suggestions
(optional improvements, not blocking)

## Summary
Brief overall assessment and key takeaways.

## Limitations
- Areas not fully reviewed (e.g., config files, generated code)
- Context that was unavailable
```

**Guidelines:**
- If no issues are found, explicitly state what was checked and any areas not covered.
- Group findings by severity, not by file.
- Be specific — always include file path and line number.
- Suggest concrete fixes, not vague advice.
- Do NOT implement any changes. This is a review-only workflow.

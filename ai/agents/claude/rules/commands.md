# Command Requirements

## GitHub CLI

**CRITICAL**: Always use `gh` CLI for all GitHub operations. Do not use other tools (curl, MCP servers, etc.) to access the GitHub API.

```bash
# Common operations
gh pr view <number>
gh pr diff <number>
gh pr list
gh pr create
gh pr checks <number>
gh issue view <number>
gh issue list
gh api repos/{owner}/{repo}/...
```

---

## Search Commands

**CRITICAL**: Always use `rg` (ripgrep) instead of traditional `grep` and `find` commands:

```bash
# ❌ Don't use grep
grep -r "pattern" .

# ✅ Use rg instead
rg "pattern"

# ❌ Don't use find with name
find . -name "*.tsx"

# ✅ Use rg with file filtering
rg --files | rg "\.tsx$"
# or
rg --files -g "*.tsx"
```

## Enforcement Rules

```
(
    r"^grep\b(?!.*\|)",
    "Use 'rg' (ripgrep) instead of 'grep' for better performance and features",
),
(
    r"^find\s+\S+\s+-name\b",
    "Use 'rg --files | rg pattern' or 'rg --files -g pattern' instead of 'find -name' for better performance",
),
```

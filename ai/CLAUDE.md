# Available MCPs for Development

**Sequential Thinking**

- Analyze feature requests and break them into clear, executable steps.
- Plan code improvements, refactoring, and architectural decisions systematically.
- Debug issues using structured, step-by-step strategies.
- Plan test coverage and test improvements thoroughly.
- Evaluate task completion and identify next steps effectively.

**Context7** (for external documentation)

- Fetch up-to-date docs not available in Hex (Tailwind, Heroicons, DaisyUI, etc.)
- Get current API references for frontend libraries

# 🤖 AI Assistant Guidelines

## Context Awareness

- When implementing features, always check existing patterns first
- Prefer composition over inheritance in all designs
- Use existing utilities before creating new ones
- Check for similar functionality in other domains/features

## Workflow Patterns

- Use "think hard" for architecture decisions
- Break complex tasks into smaller, testable units
- Validate understanding before implementation

## Search Command Requirements

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

**Enforcement Rules:**

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

# ⚠️ Important Notes

- **NEVER ASSUME OR GUESS** - When in doubt, ask for clarification
- **Always verify file paths and module names** before use

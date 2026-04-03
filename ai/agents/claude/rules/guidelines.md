# AI Assistant Guidelines

## Context Awareness

- When implementing features, always check existing patterns first
- Prefer composition over inheritance in all designs
- Use existing utilities before creating new ones
- Check for similar functionality in other domains/features

## Workflow Patterns

- Break complex tasks into smaller, testable units
- Validate understanding before implementation
- **When the user provides numbered tasks** always use the TaskCreate tool to create a task for each item before starting work. Mark each task as completed as you finish it.

## Important Notes

- **NEVER ASSUME OR GUESS** - When in doubt, ask for clarification
- **Always verify file paths and module names** before use
- **Never treat a question as approval to proceed.** If I ask about approaches, tradeoffs, or preferences, answer the question only. Wait for explicit confirmation (e.g., "go ahead", "do it", "proceed") before implementing anything.

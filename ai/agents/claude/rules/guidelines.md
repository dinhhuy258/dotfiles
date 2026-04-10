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

## Strict Mutation Control

**CRITICAL: Never modify, create, or delete files without explicit user approval.**

- **The Consent Gate:** Implementation is strictly forbidden until the user provides a clear affirmative command (e.g., "go ahead", "proceed", "do it", "yes", "LGTM").
- **Non-Approval Triggers:** Listing plans, asking questions, or providing feedback does **NOT** constitute approval. If in doubt, ask: "Shall I go ahead and make these changes?"

## Important Notes

- **NEVER ASSUME OR GUESS** - When in doubt, ask for clarification
- **Always verify file paths and module names** before use

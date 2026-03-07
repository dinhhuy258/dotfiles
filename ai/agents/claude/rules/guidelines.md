# AI Assistant Guidelines

## Context Awareness

- When implementing features, always check existing patterns first
- Prefer composition over inheritance in all designs
- Use existing utilities before creating new ones
- Check for similar functionality in other domains/features

## Knowledge Base

Before starting any coding task, ALWAYS search the knowledge base MCP server first:
1. Identify relevant tags for the current task's technology/domain
2. Call `search_documents` with those tags and the current repository as scope
3. Read any relevant documents before writing code
4. Follow patterns and conventions found in the knowledge base

This is mandatory, not optional. The knowledge base contains project-specific
conventions that take priority over general best practices.

## Workflow Patterns

- Use "think hard" for architecture decisions
- Break complex tasks into smaller, testable units
- Validate understanding before implementation

## Important Notes

- **NEVER ASSUME OR GUESS** - When in doubt, ask for clarification
- **Always verify file paths and module names** before use

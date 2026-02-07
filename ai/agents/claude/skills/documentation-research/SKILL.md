---
name: documentation-research
description: Official library and framework documentation lookup for version-specific APIs, best practices, and authoritative implementation patterns
---

# Documentation Research

## When to Use

Use this skill when you need official documentation for publicly documented libraries and frameworks:

- **Version-specific APIs**: Documentation for specific library versions
- **Official patterns**: Implementation must follow framework best practices
- **Authoritative reference**: Prefer official docs over community content
- **Current features**: Latest documentation beyond training data

**Don't use for:**
- Internal/custom libraries (use codebase exploration instead)
- General programming concepts (use native knowledge)
- Debugging runtime errors (use other tools first)

## Workflow

1. **Identify library**: Determine which public library/framework needs documentation
2. **Resolve library ID**: Use Context7 to find the library
3. **Fetch documentation**: Get specific documentation topics
4. **Apply patterns**: Implement following official best practices
5. **Reference in code**: Add doc links in comments when helpful

## Examples

**Good:**
- "How do I authenticate with Stripe API v2023-10-16?"
- "What's the official React 18 pattern for concurrent rendering?"
- "Show me Next.js 14 App Router configuration"

**Poor:**
- "How does OAuth work?" (too general)
- "Debug this custom internal library" (not publicly documented)
- "Explain closures" (general programming concept)

## Tools Available

- mcp__context7__resolve-library-id
- mcp__context7__query-docs

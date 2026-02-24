---
name: documentation-lookup
description: This skill should be used when the user asks about libraries, frameworks, API references, or needs code examples. Activates for setup questions, code generation involving libraries, or mentions of specific frameworks like React, Vue, Next.js, Prisma, Supabase, etc
allowed-tools: mcp__context7__resolve-library-id, mcp__context7__query-docs
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

## Do / Don’t Examples

**Do:**
- "How do I authenticate with Stripe API v2023-10-16?"
- "What's the official React 18 pattern for concurrent rendering?"
- "Show me Next.js 14 App Router configuration"

**Don't:**
- "How does OAuth work?" (too general)
- "Debug this custom internal library" (not publicly documented)
- "Explain closures" (general programming concept)

## Workflow

### Step 1: Resolve the Library ID

Call `resolve-library-id` with:

- `libraryName`: The library name extracted from the user's question
- `query`: The user's full question (improves relevance ranking)

### Step 2: Select the Best Match

From the resolution results, choose based on:

- Exact or closest name match to what the user asked for
- Higher benchmark scores indicate better documentation quality
- If the user mentioned a version (e.g., "React 19"), prefer version-specific IDs

### Step 3: Fetch the Documentation

Call `query-docs` with:

- `libraryId`: The selected Context7 library ID (e.g., `/vercel/next.js`)
- `query`: The user's specific question

### Step 4: Use the Documentation

Incorporate the fetched documentation into your response:

- Answer the user's question using current, accurate information
- Include relevant code examples from the docs
- Cite the library version when relevant

## Guidelines

- **Be specific**: Pass the user's full question as the query for better results
- **Version awareness**: When users mention versions ("Next.js 15", "React 19"), use version-specific library IDs if available from the resolution step
- **Prefer official sources**: When multiple matches exist, prefer official/primary packages over community forks

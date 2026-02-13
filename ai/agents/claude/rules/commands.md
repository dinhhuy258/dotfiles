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

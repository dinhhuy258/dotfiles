---
name: rails-debug
description: Safe staging/production debugging via Rails console over tmux. Reads project code (models, services, policies, data flow) to build intelligent Rails console queries, then executes via tmux-relay with mandatory user confirmation. Trigger when debugging prod/staging issues, investigating data, running Rails console commands that need codebase context, or any controlled interaction with a remote Rails console pane.
user-invocable: true
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, AskUserQuestion
---

# Rails Debug — Safe Rails Console Debugging

Combine codebase understanding with controlled Rails console execution via tmux-relay.

## Safety Contract

**CRITICAL — applies to EVERY command, read or write:**

1. Display the exact command before asking for confirmation
2. Use AskUserQuestion with options `["Yes, execute", "Skip", "Modify"]` for every `tmux-relay send`
3. NEVER send a command without explicit user approval
4. For write/mutation operations, add a `⚠️ WRITE OPERATION` warning before the command

## Phase 1: Pane Discovery

Run `tmux-relay list` to find available panes.

- **No panes** → STOP. Tell user: *"No tmux panes available. Start a tmux session with a Rails console pane and retry."*
- **One pane** → Auto-select. Inform user: *"Using pane X (command: Y)."*
- **Multiple panes** → Show pane list. Ask user to choose via AskUserQuestion with pane options.

Store the selected pane target for the session.

## Phase 2: Understand the Problem

1. **Ask** — Use AskUserQuestion to understand what the user wants to debug or investigate
2. **Analyze code** — Explore relevant models, services, policies, scopes, associations, and validations using Read/Grep/Glob/Serena tools. Do this silently — don't narrate each file read
3. **Summarize** — Briefly explain the relevant code paths and data flow
4. **Propose plan** — Outline debugging steps and the Rails console commands you'll suggest

## Phase 3: Debug Loop

One command at a time:

1. **Propose** — Show the exact command with a brief explanation:
   ```
   Command: User.where(email: 'foo@bar.com').first
   Purpose: Find the user record by email to inspect their current state
   ```
2. **Confirm** — AskUserQuestion: `["Yes, execute", "Skip", "Modify"]`
   - *Yes* → run `tmux-relay send -t <pane> "<command>"`
   - *Skip* → move to next step
   - *Modify* → ask for the modified command, then confirm again
3. **Interpret output** — Explain what the result means in context of the codebase
4. **Next step** — Suggest the next command or ask if the issue is resolved

Repeat until resolved or user stops.

## tmux-relay Reference

```bash
# List panes (INDEX, ID, COMMAND, TITLE)
tmux-relay list

# Send command (default 30s timeout)
tmux-relay send -t <pane> "<command>"

# Longer timeout for slow queries
tmux-relay send -t <pane> --timeout 60 "<command>"
```

Target by index (`1`) or pane ID (`%2`).

### Quote Escaping

Ruby commands often contain quotes. Use the opposite quote style for the outer shell:

```bash
# Double quotes inside → wrap with single quotes outside, or escape
tmux-relay send -t 1 'User.where("email LIKE ?", "%@example.com")'
tmux-relay send -t 1 "User.where(email: 'test@example.com')"
```

## Guidelines

- **Read-only first** — Start with read queries before suggesting mutations
- **Use codebase context** — Reference specific model names, associations, scopes, and validations from the code
- **Timeout awareness** — Use `--timeout 60` or higher for large queries or data exports
- **One command at a time** — Never batch commands without individual confirmation
- **Explain before executing** — The user should understand what each command does and why

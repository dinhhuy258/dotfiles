---
name: ssh-shell
description: Interactive shell helper via tmux-relay. Helps users perform tasks on remote servers through SSH sessions — run commands, inspect logs, manage services, check system state. No codebase exploration needed. Trigger when the user wants to interact with a shell pane for server operations.
user-invocable: true
disable-model-invocation: true
allowed-tools: AskUserQuestion
---

# SSH Shell — Interactive Shell Helper

Help users perform tasks on remote servers via shell commands executed through tmux-relay.

## Safety Modes

Three execution modes control how commands are confirmed. Default is **strict**.

### Strict Mode (default)

- Confirm **every** command (read and write) before execution
- Use AskUserQuestion with options `["Yes, execute", "Skip", "Modify"]` for every `tmux-relay send`
- NEVER send a command without explicit user approval

### Guardrail Mode

- **Read commands** — execute automatically without confirmation
- **Write/mutation commands** — confirm before execution using AskUserQuestion with options `["Yes, execute", "Skip", "Modify"]`
- Always display the command and its purpose before executing, even for auto-executed reads

### Yolo Mode

- Execute **all** commands (read and write) without confirmation
- Still display each command and its purpose before executing

### Common Rules (all modes)

- For write/mutation operations, always add a `⚠️ WRITE OPERATION` warning before the command

## Phase 1: Pane Discovery

Run `tmux-relay list` to find available panes.

- **No panes** → STOP. Tell user: *"No tmux panes available. Start a tmux session with an SSH pane and retry."*
- **One pane** → Auto-select. Inform user: *"Using pane X (command: Y)."*
- **Multiple panes** → Show pane list. Ask user to choose via AskUserQuestion with pane options.

Store the selected **window** (e.g., `@35`) and **pane index** (e.g., `2`) for the session. Both are required for all subsequent commands.

## Phase 2: Mode Selection

Ask the user which safety mode to use via AskUserQuestion with options `["Strict (confirm all)", "Guardrail (confirm writes only)", "Yolo (no confirmation)"]`. Default to **Strict** if the user skips.

Store the selected mode for the session.

## Phase 3: Understand the Task

1. **Ask** — Use AskUserQuestion to understand what the user wants to accomplish on the server
2. **Propose plan** — Outline the steps and shell commands you'll suggest to achieve the goal

## Phase 4: Execution Loop

One command at a time:

1. **Propose** — Show the exact command with a brief explanation:
   ```
   Command: tail -n 100 /var/log/nginx/error.log
   Purpose: Check recent Nginx error logs for the reported 502 errors
   ```
2. **Confirm or Execute** — Behavior depends on the active safety mode:
   - **Strict** → AskUserQuestion: `["Yes, execute", "Skip", "Modify"]` for every command
   - **Guardrail** → Auto-execute read commands; AskUserQuestion: `["Yes, execute", "Skip", "Modify"]` for write/mutation commands
   - **Yolo** → Execute immediately without asking

   For all modes:
   - *Yes / auto-execute* → run `tmux-relay send -w <window> -t <pane> "<command>"`
   - *Skip* → move to next step
   - *Modify* → ask for the modified command, then confirm again
3. **Interpret output** — Explain what the result means in context of the task
4. **Next step** — Suggest the next command or ask if the task is complete

Repeat until the task is done or the user stops.

## tmux-relay Reference

```bash
# List panes (WINDOW, INDEX, ID, COMMAND, TITLE)
tmux-relay list

# Send command (default 30s timeout) — always include -w <window>
tmux-relay send -w <window> -t <pane> "<command>"

# Longer timeout for slow commands
tmux-relay send -w <window> -t <pane> --timeout 60 "<command>"
```

Target pane by index (`1`) or pane ID (`%2`). Always include `-w <window>` (e.g., `-w @35`).

### Quote Escaping

Shell commands often contain quotes. Use the opposite quote style for the outer shell:

```bash
# Single quotes inside → wrap with double quotes outside
tmux-relay send -w @35 -t 1 "grep 'error' /var/log/syslog"

# Double quotes inside → wrap with single quotes outside
tmux-relay send -w @35 -t 1 'ps aux | grep "nginx"'
```

## Guidelines

- **Read-only first** — Start with non-destructive commands to understand the current state before suggesting mutations
- **Be cautious with destructive commands** — `rm`, `kill`, `sudo`, service restarts, and package operations deserve extra care
- **Pipe large outputs** — Use `| head`, `| tail`, or `| grep` to avoid flooding the terminal with output
- **Timeout awareness** — Use `--timeout 60` or higher for long-running commands
- **One command at a time** — Never batch commands without individual confirmation
- **Explain before executing** — The user should understand what each command does and why

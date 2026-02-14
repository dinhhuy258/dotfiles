#!/usr/bin/env bash
# claude-notify.sh — Claude Code sound + notification hook
set -uo pipefail

HOOKS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOUNDS_DIR="$HOOKS_DIR/sounds"

INPUT=$(cat)

eval "$(printf '%s' "$INPUT" | SOUNDS_DIR="$SOUNDS_DIR" python3 -c "
import sys, json, os, random, shlex
q = shlex.quote

try:
    data = json.loads(sys.stdin.read())
except Exception:
    print('CATEGORY=')
    sys.exit(0)

event = data.get('hook_event_name', '')
ntype = data.get('notification_type', '')
cwd = data.get('cwd', '')

project = cwd.rsplit('/', 1)[-1] if cwd else 'claude'
sounds_dir = os.environ.get('SOUNDS_DIR', '')

sounds_map = {
    'task.complete':    ['complete_1.mp3'],
    'input.required':   ['permission_1.mp3', 'permission_2.mp3'],
}

category = ''
notify_msg = ''
if event == 'Stop':
    category = 'task.complete'
    notify_msg = project + ' — Task complete'
elif event == 'PermissionRequest':
    category = 'input.required'
    notify_msg = project + ' — Permission needed'
elif event == 'Notification':
    if ntype == 'idle_prompt':
        notify_msg = project + ' — Waiting for input'

sound_file = ''
if category in sounds_map:
    pick = random.choice(sounds_map[category])
    sound_file = os.path.join(sounds_dir, pick)

print('CATEGORY=' + q(category))
print('SOUND_FILE=' + q(sound_file))
print('NOTIFY_MSG=' + q(notify_msg))
" 2>/dev/null)"

# Play sound
if [ -n "${SOUND_FILE:-}" ] && [ -f "$SOUND_FILE" ]; then
  afplay -v 1.0 "$SOUND_FILE" >/dev/null 2>&1 &
fi

# Desktop notification
if [ -n "${NOTIFY_MSG:-}" ]; then
  if command -v terminal-notifier &>/dev/null; then
    terminal-notifier -title "Claude Code" -message "$NOTIFY_MSG" -group "claude-code" >/dev/null 2>&1 &
  else
    osascript -e "display notification \"$NOTIFY_MSG\" with title \"Claude Code\"" >/dev/null 2>&1 &
  fi
fi

exit 0

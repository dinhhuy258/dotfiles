local M = {}

function M.setup()
  local status_ok, tmux = pcall(require, "tmux")
  if not status_ok then
    return
  end

  tmux.setup {
    copy_sync = {
      enable = false,
      redirect_to_clipboard = false,
      sync_clipboard = false,
      sync_deletes = false,
    },
    navigation = {
      -- Enables default keybindings (C-hjkl) for normal mode
      enable_default_keybindings = true,
    },
    resize = {
      -- Enables default keybindings (A-hjkl) for normal mode
      enable_default_keybindings = true,
      resize_step_x = 3,
      resize_step_y = 3,
    },
  }
end

return M

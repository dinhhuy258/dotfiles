local M = {}

M.setup = function()
  local status_ok, copilot = pcall(require, "copilot")
  if not status_ok then
    return
  end

  copilot.setup {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      debounce = 75,
      keymap = {
        accept = "<C-j>",
        accept_word = false,
        accept_line = false,
        next = "<C-k>",
        prev = "<C-l>",
      },
    },
    panel = {
      enabled = false,
    },
  }
end

return M

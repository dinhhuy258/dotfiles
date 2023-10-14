local M = {}

M.setup = function()
  require("copilot").setup {
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
  }
end

return M

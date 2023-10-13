local M = {}

M.setup = function()
  require("copilot").setup {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      debounce = 75,
      keymap = {
        accept = "<Right>",
        accept_word = false,
        accept_line = false,
        next = "<Up>",
        prev = "<Down>",
      },
    },
  }
end

return M

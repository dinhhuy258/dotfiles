local M = {}

M.setup = function()
  vim.g.copilot_no_tab_map = true

  local keymap = require "utils.keymap"
  keymap.set("i", "<C-j>", 'copilot#Accept("<CR>")', { noremap = true, silent = true, expr = true })
end

return M

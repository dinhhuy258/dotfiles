local M = {}

M.setup = function()
  vim.g.copilot_no_tab_map = true

  local utils = require "utils"
  utils.set_keymap("i", "<C-j>", 'copilot#Accept("<CR>")', { noremap = true, silent = true, expr = true })
end

return M


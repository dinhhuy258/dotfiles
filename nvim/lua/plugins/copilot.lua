local keymappings = require "keymappings"

local M = {}

M.setup = function()
  vim.g.copilot_no_tab_map = true

  keymappings.set("i", "<C-j>", 'copilot#Accept("<CR>")', { noremap = true, silent = true, expr = true })
end

return M

local keymaps = require "config.keymaps"

local M = {}

M.setup = function()
  keymaps.set("n", "<Leader>aa", "<cmd>:A<CR>", { noremap = true, silent = true })
end

return M

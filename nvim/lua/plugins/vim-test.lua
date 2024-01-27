local keymaps = require "config.keymaps"

local M = {}

M.setup = function()
  vim.g["test#strategy"] = "vimux"

  -- setup keymap
  -- run nearest test
  keymaps.set("n", "<Leader>tt", ":TestNearest<CR>", { noremap = true })
  -- run the current file
  keymaps.set("n", "<Leader>tT", ':TestFile<CR>', { noremap = true })
  -- run the last test
  keymaps.set("n", "<Leader>t.", ':TestLast<CR>', { noremap = true })
end

return M

local M = {}

M.setup = function()
  local status_ok, hop = pcall(require, "hop")
  if not status_ok then
    return
  end

  hop.setup { keys = "etovxqpdygfblzhckisuran" }

  local utils = require "utils"

  utils.set_keymap("n", "<Leader><Leader>", ":HopChar1<CR>", { noremap = false })
  utils.set_keymap("n", "<Leader>l", ":HopLine<CR>", { noremap = false })
end

return M

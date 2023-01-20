local keymap = require "utils.keymap"

local M = {}

M.setup = function()
  local status_ok, hop = pcall(require, "hop")
  if not status_ok then
    return
  end

  hop.setup { keys = "etovxqpdygfblzhckisuran" }

  keymap.set("n", "<Leader><Leader>", ":HopChar1<CR>", { noremap = false })
  keymap.set("n", "<Leader>l", ":HopLine<CR>", { noremap = false })
end

return M

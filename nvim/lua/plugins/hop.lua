local keymaps = require "config.keymaps"

local M = {}

M.setup = function()
  local status_ok, hop = pcall(require, "hop")
  if not status_ok then
    return
  end

  hop.setup { keys = "etovxqpdygfblzhckisuran" }

  keymaps.set("n", "<Leader><Leader>", ":HopChar1<CR>", { noremap = false })
  keymaps.set("n", "<Leader>l", ":HopLine<CR>", { noremap = false })
end

return M

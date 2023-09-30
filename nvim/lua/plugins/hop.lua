local keymappings = require "keymappings"

local M = {}

M.setup = function()
  local status_ok, hop = pcall(require, "hop")
  if not status_ok then
    return
  end

  hop.setup { keys = "etovxqpdygfblzhckisuran" }

  keymappings.set("n", "<Leader><Leader>", ":HopChar1<CR>", { noremap = false })
  keymappings.set("n", "<Leader>l", ":HopLine<CR>", { noremap = false })
end

return M

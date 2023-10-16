local keymaps = require "config.keymaps"

local M = {}

M.setup = function()
  local treesj_ok, treesj = pcall(require, "treesj")
  if not treesj_ok then
    return
  end

  treesj.setup {
    use_default_keymaps = false,
  }

  keymaps.set("n", "<Leader>jj", function()
    treesj.toggle()
  end, { noremap = true, silent = true })
end

return M

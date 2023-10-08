local keymaps = require "config.keymaps"

local M = {}

M.setup = function()
  local status_ok, _ = pcall(require, "nvim-navbuddy")
  if not status_ok then
    return
  end

  keymaps.set("n", "<Leader>cc", ":Navbuddy<CR>", { noremap = false })
end

return M

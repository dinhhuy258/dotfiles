local icons = require "icons"

local M = {}

M.setup = function()
  local status_ok, ibl = pcall(require, "ibl")
  if not status_ok then
    return
  end

  ibl.setup {
    scope = {
      enabled = false,
    },
    exclude = {
      filetypes = {
        "help",
        "terminal",
        "startify",
        "sfm",
      },
      buftypes = {
        "terminal",
      },
    },
    indent = {
      char = icons.ibl.char,
      tab_char = icons.ibl.tab_char,
    },
  }
end

return M

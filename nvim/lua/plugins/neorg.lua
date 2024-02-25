local keymaps = require "config.keymaps"

local M = {}

M.setup = function()
  local status_ok, neorg = pcall(require, "neorg")
  if not status_ok then
    return
  end

  neorg.setup {
    load = {
      ["core.defaults"] = {}, -- Loads default behaviour
      ["core.concealer"] = {}, -- Adds pretty icons to your documents
      ["core.dirman"] = { -- Manages Neorg workspaces
        config = {
          workspaces = {
            notes = "~/Workspace/neorg",
          },
          default_workspace = "notes",
        },
      },
    },
  }

  keymaps.set("n", "<Leader>ww", ":Neorg index<CR>", { noremap = true })
end

return M

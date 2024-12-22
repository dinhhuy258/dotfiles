local keymaps = require "config.keymaps"

local M = {}

M.setup = function()
  local fzf_status_ok, fzf = pcall(require, "fzf-lua")
  if not fzf_status_ok then
    return
  end

  local actions = require "fzf-lua.actions"

  fzf.setup {
    actions = {
      files = {
        ["ctrl-h"] = actions.file_split,
        ["ctrl-v"] = actions.file_vsplit,
      },
    },
  }

  keymaps.set("n", "<Leader>ff", ":lua require('fzf-lua').files()<CR>", { noremap = true })
end

return M

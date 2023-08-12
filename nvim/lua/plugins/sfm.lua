local keymap = require "utils.keymap"

local M = {}

M.setup = function()
  local sfm_explorer = require("sfm").setup {
    view = {
      render_selection_in_sign = true,
    },
    renderer = {
      icons = {
        selection = "*",
      },
    },
  }

  sfm_explorer:load_extension "sfm-bookmark"
  sfm_explorer:load_extension "sfm-filter"
  sfm_explorer:load_extension "sfm-git"
  sfm_explorer:load_extension "sfm-telescope"
  sfm_explorer:load_extension "sfm-paste"

  keymap.set("n", "<F1>", "<CMD>SFMToggle<CR>", { noremap = true, silent = true })
  keymap.set("n", "fm", "<CMD>SFMToggle<CR>", { noremap = true, silent = true })
end

return M

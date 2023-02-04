local keymap = require "utils.keymap"

local M = {}

M.setup = function()
  local sfm_explorer = require("sfm").setup {}
  sfm_explorer:load_extension("sfm-fs", {
    view = {
      render_selection_in_sign = true,
    },
    icons = {
      selection = "*",
    },
  })
  sfm_explorer:load_extension "sfm-bookmark"
  sfm_explorer:load_extension "sfm-filter"
  sfm_explorer:load_extension "sfm-git"
  sfm_explorer:load_extension "sfm-telescope"

  keymap.set("n", "<F1>", "<CMD>SFMToggle<CR>", { noremap = true, silent = true })
end

return M

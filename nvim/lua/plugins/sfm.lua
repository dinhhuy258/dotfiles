local keymap = require "utils.keymap"

local M = {}

M.setup = function()
  local sfm_explorer = require("sfm").setup {
    view = {
      selection_render_method = "sign",
    },
    renderer = {
      icons = {
        selection = "*",
      },
    },
    mappings = {
      list = {
        {
          key = "<C-v>",
          action = nil,
        },
        {
          key = "<C-h>",
          action = nil,
        },
        {
          key = "V",
          action = "vsplit",
        },
        {
          key = "H",
          action = "split",
        },
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

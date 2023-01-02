local M = {}

M.setup = function()
  local sfm_explorer = require("sfm").setup {}
  sfm_explorer:load_extension "sfm-bookmark"
  sfm_explorer:load_extension "sfm-filter"

  local utils = require "utils"
  utils.set_keymap("n", "<F1>", "<CMD>SFMToggle<CR>", { noremap = true, silent = true })
end

return M

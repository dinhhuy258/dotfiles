local M = {}

M.setup = function()
  require("sfm").setup {}
  require("sfm").load_extention "sfm-bookmark"

  local utils = require "utils"
  utils.set_keymap("n", "<F1>", "<CMD>SFMToggle<CR>", { noremap = true, silent = true })
end

return M

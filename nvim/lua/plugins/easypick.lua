local keymaps = require "config.keymaps"

local M = {}

M.setup = function()
  local status_ok, easypick = pcall(require, "easypick")
  if not status_ok then
    return
  end

  easypick.setup {
    pickers = {
      -- list files that have conflicts with diffs in preview
      {
        name = "git_conflicts",
        command = "git diff --name-only --diff-filter=U --relative",
        previewer = easypick.previewers.file_diff(),
      },
    },
  }

  keymaps.set("n", "<Leader>fc", ":Easypick git_conflicts<CR><CR>", { noremap = true })
end

return M

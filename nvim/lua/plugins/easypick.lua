local keymaps = require "config.keymaps"

local M = {}

M.setup = function()
  local status_ok, easypick = pcall(require, "easypick")
  if not status_ok then
    return
  end

  local get_default_branch = "git remote show origin | grep 'HEAD branch' | cut -d' ' -f5"
  local base_branch = vim.fn.system(get_default_branch) or "main"

  easypick.setup {
    pickers = {
      -- diff current branch with base_branch and show files that changed with respective diffs in preview
      {
        name = "git_changed_files",
        command = "git diff --name-only $(git merge-base HEAD " .. base_branch .. " )",
        previewer = easypick.previewers.branch_diff { base_branch = base_branch },
      },
      -- list files that have conflicts with diffs in preview
      {
        name = "git_conflicts",
        command = "git diff --name-only --diff-filter=U --relative",
        previewer = easypick.previewers.file_diff(),
      },
    },
  }

  keymaps.set("n", "<Leader>fG", ":Easypick git_changed_files<CR>", { noremap = true })
  keymaps.set("n", "<Leader>fc", ":Easypick git_conflicts<CR><CR>", { noremap = true })
end

return M

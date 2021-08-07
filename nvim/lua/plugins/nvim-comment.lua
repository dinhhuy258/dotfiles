local M = {}

M.setup = function()
  local status_ok, nvim_comment = pcall(require, "nvim_comment")
  if not status_ok then
    return
  end

  nvim_comment.setup {
    -- Linters prefer comment and line to have a space in between markers
    marker_padding = true,
    -- Should comment out empty or whitespace only lines
    comment_empty = false,
    -- Should key mappings be created
    create_mappings = true,
    -- Normal mode mapping left hand side
    line_mapping = "<Leader>cl",
    -- Visual/Operator mapping left hand side
    operator_mapping = "<Leader>cl",
    -- Hook function to call before commenting takes place
    hook = nil,
  }

  -- The line mapping config in normal node does not work well
  local utils = require "utils"
  utils.set_keymap("n", "<Leader>cl", "<CMD>CommentToggle<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Leader>cl", "<CMD>CommentToggle<CR>", { noremap = false, silent = true })
end

return M

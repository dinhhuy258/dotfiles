local keymaps = require "config.keymaps"

local M = {}

M.setup = function()
  local status_ok, comment = pcall(require, "Comment")
  if not status_ok then
    return
  end

  comment.setup {
    ---Add a space b/w comment and the line
    padding = true,
    ---Whether the cursor should stay at its position
    sticky = true,
    ---Lines to be ignored while (un)comment
    ignore = "^$",
    ---Enable keybindings
    ---NOTE: If given `false` then the plugin won't create any mappings
    mappings = {
      ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
      basic = false,
      ---Extra mapping; `gco`, `gcO`, `gcA`
      extra = false,
      ---Extended mapping; `g>` `g<` `g>[count]{motion}` `g<[count]{motion}`
      extended = false,
    },
    ---Function to call before (un)comment
    pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    ---Function to call after (un)comment
    post_hook = nil,
  }

  keymaps.set(
    "n",
    "<Leader>cl",
    "<CMD>lua require('Comment.api').toggle.linewise.current()<CR>",
    { noremap = true, silent = true }
  )
  keymaps.set(
    "x",
    "<Leader>cl",
    "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
    { noremap = true, silent = true }
  )
end

return M

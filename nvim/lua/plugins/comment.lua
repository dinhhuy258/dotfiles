local M = {}

M.setup = function()
  local status_ok, comment = pcall(require, "Comment")
  if not status_ok then
    return
  end

  comment.setup {
    ---Add a space b/w comment and the line
    ---@type boolean
    padding = true,

    ---Lines to be ignored while comment/uncomment.
    ---Could be a regex string or a function that returns a regex string.
    ---Example: Use '^$' to ignore empty lines
    ---@type string|function
    ignore = nil,

    ---Whether to create basic (operator-pending) and extra mappings for NORMAL/VISUAL mode
    ---@type table
    mappings = {
      ---operator-pending mapping
      ---Includes `gcc`, `gcb`, `gc[count]{motion}` and `gb[count]{motion}`
      basic = true,
      ---extended mapping
      ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
      extra = false,
    },

    ---LHS of line and block comment toggle mapping in NORMAL/VISUAL mode
    ---@type table
    toggler = {
      ---line-comment toggle
      line = "gcc",
      ---block-comment toggle
      block = "gbc",
    },

    -- -LHS of line and block comment operator-mode mapping in NORMAL/VISUAL mode
    ---@type table
    opleader = {
      ---line-comment opfunc mapping
      line = "gc",
      ---block-comment opfunc mapping
      block = "gb",
    },

    ---Pre-hook, called before commenting the line
    ---@type function|nil
    pre_hook = nil,

    ---Post-hook, called after commenting is done
    ---@type function|nil
    post_hook = nil,
  }

  -- The line mapping config in normal node does not work well
  local utils = require "utils"
  utils.set_keymap("n", "<Leader>cl", "<CMD>lua require('Comment').toggle()<CR>", { noremap = true, silent = true })
  utils.set_keymap(
    "x",
    "<Leader>cl",
    "<ESC><CMD>lua require('Comment.api').gc(vim.fn.visualmode())<CR>",
    { noremap = true, silent = true }
  )
end

return M

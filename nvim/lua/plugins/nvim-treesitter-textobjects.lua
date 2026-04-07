local keymaps = require "config.keymaps"

local M = {}

M.setup = function()
  require("nvim-treesitter-textobjects").setup {
    select = {
      lookahead = true,
    },
    move = {
      set_jumps = true,
    },
  }

  local select = require("nvim-treesitter-textobjects.select")
  local move = require("nvim-treesitter-textobjects.move")
  local swap = require("nvim-treesitter-textobjects.swap")

  -- Select keymaps
  keymaps.set({ "x", "o" }, "af", function() select.select_textobject("@function.outer", "textobjects") end)
  keymaps.set({ "x", "o" }, "if", function() select.select_textobject("@function.inner", "textobjects") end)
  keymaps.set({ "x", "o" }, "ac", function() select.select_textobject("@class.outer", "textobjects") end)
  keymaps.set({ "x", "o" }, "ic", function() select.select_textobject("@class.inner", "textobjects") end)
  keymaps.set({ "x", "o" }, "ia", function() select.select_textobject("@parameter.inner", "textobjects") end)
  keymaps.set({ "x", "o" }, "aa", function() select.select_textobject("@parameter.outer", "textobjects") end)

  -- Move keymaps
  keymaps.set({ "n", "x", "o" }, "gcf", function() move.goto_next_start("@function.outer", "textobjects") end)
  keymaps.set({ "n", "x", "o" }, "gcc", function() move.goto_next_start("@class.outer", "textobjects") end)
  keymaps.set({ "n", "x", "o" }, "gca", function() move.goto_next_start("@parameter.inner", "textobjects") end)
  keymaps.set({ "n", "x", "o" }, "gcF", function() move.goto_previous_start("@function.outer", "textobjects") end)
  keymaps.set({ "n", "x", "o" }, "gcC", function() move.goto_previous_start("@class.outer", "textobjects") end)
  keymaps.set({ "n", "x", "o" }, "gcA", function() move.goto_previous_start("@parameter.inner", "textobjects") end)

  -- Swap keymaps
  keymaps.set("n", "<leader>a", function() swap.swap_next("@parameter.inner") end)
  keymaps.set("n", "<leader>A", function() swap.swap_previous("@parameter.inner") end)
end

return M

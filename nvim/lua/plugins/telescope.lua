local M = {}

M.setup = function()
  local status_ok, telescope = pcall(require, "telescope")
  if not status_ok then
    return
  end

  local actions = require "telescope.actions"

  telescope.setup {
    defaults = {
      entry_prefix = "  ",
      initial_mode = "insert",
      prompt_prefix = " ",
      selection_caret = " ",
      path_display = { "smart" },
      scroll_strategy = "limit",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "vertical",
      layout_config = {
        preview_cutoff = 0,
        vertical = {
          prompt_position = "top",
          mirror = true,
        },
      },
      mappings = {
        i = {
          ["<C-c>"] = actions.close,

          ["<CR>"] = actions.select_default,
          ["<C-h>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,

          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,

          ["<C-j>"] = actions.move_selection_next,
          ["<Down>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<Up>"] = actions.move_selection_previous,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<C-?>"] = actions.which_key,
        },

        n = {
          ["<esc>"] = actions.close,
          ["<C-c>"] = actions.close,

          ["<CR>"] = actions.select_default,
          ["<C-h>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,

          ["j"] = actions.move_selection_next,
          ["<Down>"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["<Up>"] = actions.move_selection_previous,
          ["gg"] = actions.move_to_top,
          ["G"] = actions.move_to_bottom,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["?"] = actions.which_key,
        },
      },
    },
    pickers = {},
    extensions = {},
  }

  local utils = require "utils"

  utils.set_keymap("n", "<Leader>fg", ":lua require('telescope.builtin').git_status()<CR>", { noremap = true })
  utils.set_keymap("n", "<Leader>fc", ":lua require('telescope.builtin').git_branches()<CR>", { noremap = true })
  utils.set_keymap("n", "<Leader>fb", ":lua require('telescope.builtin').buffers()<CR>", { noremap = true })
  utils.set_keymap("n", "<Leader>ft", ":lua require('telescope.builtin').treesitter()<CR>", { noremap = true })
end

return M

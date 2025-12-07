local keymaps = require "config.keymaps"
local icons = require "icons"

local M = {}

M.setup = function()
  local status_ok, telescope = pcall(require, "telescope")
  if not status_ok then
    return
  end

  local actions = require "telescope.actions"

  -- Load extensions (minimal set)
  telescope.load_extension "ui-select"
  telescope.load_extension "sfm-telescope"

  telescope.setup {
    defaults = {
      entry_prefix = "  ",
      initial_mode = "insert",
      prompt_prefix = icons.telescope.prompt_prefix,
      selection_caret = icons.telescope.selection_caret,
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
          width = 0.5,
        },
      },
      mappings = {
        i = {
          ["<esc>"] = actions.close,
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
      },
    },
    pickers = {
      -- Minimal picker configurations
      lsp_references = {
        show_line = false,
      },
      lsp_definitions = {
        show_line = false,
      },
      lsp_implementations = {
        show_line = false,
      },
    },
    extensions = {
      ["ui-select"] = {
        -- Use telescope for vim.ui.select
      },
    },
  }

  -- Keep only treesitter keybinding (everything else moved to fzf.vim)
  keymaps.set("n", "<Leader>ft", ":lua require('telescope.builtin').treesitter()<CR>", { noremap = true })
end

return M

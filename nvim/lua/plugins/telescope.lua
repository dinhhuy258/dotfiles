local M = {}

M.setup = function()
  local telescope_status_ok, telescope = pcall(require, "telescope")
  if not telescope_status_ok then
    return
  end

  local telescope_action_status_ok, actions = pcall(require, "telescope.actions")
  if not telescope_action_status_ok then
    return
  end

  telescope.setup(  {
    active = false,
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "descending",
      layout_strategy = "vertical",
      layout_config = {
        width = 0.75,
        prompt_position = "bottom",
        preview_cutoff = 0,
        horizontal = { mirror = false },
        vertical = { mirror = false },
      },
      file_sorter = require("telescope.sorters").get_fzy_sorter,
      file_ignore_patterns = {},
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      path_display = { shorten = 128 },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      use_less = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

      mappings = {
        i = {
          ["<C-c>"] = actions.close,
          ["<C-j>"] = actions.cycle_history_next,
          ["<C-k>"] = actions.cycle_history_prev,
          ["<CR>"] = actions.select_default + actions.center,
        },
        n = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-c>"] = actions.close,
        },
      },
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
    },
  }
)

local utils = require 'utils'

utils.set_keymap('n', '<Leader>fr', ':Telescope live_grep<CR>', { noremap = true })
utils.set_keymap('n', '<Leader>fg', ':Telescope git_status<CR>', { noremap = true })
utils.set_keymap('n', '<Leader>fb', ':Telescope buffers<CR>', { noremap = true })
utils.set_keymap('n', '<Leader>fm', ':Telescope marks<CR>', { noremap = true })
utils.set_keymap('n', '<Leader>fe', ':Telescope oldfiles<CR>', { noremap = true })
utils.set_keymap('n', '<Leader>ff', ':Telescope find_files<CR>', { noremap = true })

end

return M


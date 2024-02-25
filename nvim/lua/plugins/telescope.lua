local keymaps = require "config.keymaps"
local icons = require "icons"

local M = {}

local action_state = require "telescope.actions.state"
local helpers = require "telescope-live-grep-args.helpers"

local function quote_prompt(opts)
  opts = opts or {}
  opts = vim.tbl_extend("force", {
    quote_char = '"',
    postfix = " ",
    trim = true,
  }, opts)

  return function(prompt_bufnr)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local prompt = picker:_get_prompt()
    if opts.trim then
      prompt = vim.trim(prompt)
    end

    if prompt == nil or prompt == "" then
      return
    end

    if prompt:sub(1, 1) ~= "\"" then
      prompt = helpers.quote(prompt, { quote_char = opts.quote_char })
    end

    local postfix = vim.trim(opts.postfix)
    if prompt ~= nil and prompt ~= "" and prompt:sub(-#postfix) ~= postfix then
      prompt = prompt .. opts.postfix
    end

    picker:set_prompt(prompt)
  end
end

M.setup = function()
  local status_ok, telescope = pcall(require, "telescope")
  if not status_ok then
    return
  end

  local actions = require "telescope.actions"

  telescope.load_extension "ui-select"
  telescope.load_extension "sfm-telescope"
  telescope.load_extension "harpoon"

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
      live_grep = {
        only_sort_text = true,
      },
      find_files = {
        hidden = false,
        find_command = { "fd", "--type", "f", "--follow" },
      },
    },
    extensions = {
      ["ui-select"] = {},
      live_grep_args = {
        auto_quoting = true,
        mappings = {
          i = {
            ["<C-k>"] = quote_prompt(),
            ["<C-i>"] = quote_prompt { postfix = " --iglob " },
          },
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          "--glob=!.git/",
        },
      },
    },
  }

  keymaps.set("n", "<Leader>fg", ":lua require('telescope.builtin').git_status()<CR>", { noremap = true })
  keymaps.set("n", "<Leader>fc", ":lua require('telescope.builtin').git_branches()<CR>", { noremap = true })
  keymaps.set("n", "<Leader>fb", ":lua require('telescope.builtin').buffers()<CR>", { noremap = true })
  keymaps.set("n", "<Leader>ft", ":lua require('telescope.builtin').treesitter()<CR>", { noremap = true })
  keymaps.set("n", "<Leader>fh", ":lua require('telescope.builtin').command_history()<CR>", { noremap = true })
  keymaps.set("n", "<Leader>f.", ":lua require('telescope.builtin').resume()<CR>", { noremap = true })
  keymaps.set("n", "<leader>fr", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
end

return M

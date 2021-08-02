local M = {}

M.setup = function()
  local status_ok, config = pcall(require, "nvim-tree.config")
  if not status_ok then
    return
  end

  local nvim_tree_config = {
    side = "left",
    show_icons = {
      git = 1,
      folders = 1,
      files = 1,
      folder_arrows = 1,
    },
    width = 40,
    ignore = { ".git", "node_modules", ".cache" },
    auto_open = 1,
    auto_close = 1,
    quit_on_open = 0,
    follow = 1,
    hide_dotfiles = 1,
    git_hl = 1,
    root_folder_modifier = ":t",
    tab_open = 0,
    auto_resize = 1,
    lsp_diagnostics = 1,
    auto_ignore_ft = { "startify", "dashboard" },
    icons = {
      default = "",
      symlink = "",
      git = {
        unstaged = "",
        staged = "S",
        unmerged = "",
        renamed = "➜",
        untracked = "U",
        deleted = "",
        ignored = "◌",
      },
      folder = {
        arrow_open = "",
        arrow_closed = "",
        default = "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = "",
        symlink_open = "",
      },
      lsp = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      },
    },
  }

  for opt, val in pairs(nvim_tree_config) do
    vim.g["nvim_tree_" .. opt] = val
  end

  local tree_cb = config.nvim_tree_callback
  vim.g.nvim_tree_bindings = {
    { key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit") },
    { key = {"<2-RightMouse>", "<C-]>"},    cb = tree_cb("cd") },
    { key = "<C-v>",                        cb = tree_cb("vsplit") },
    { key = "<C-h>",                        cb = tree_cb("split") },
    { key = "<C-t>",                        cb = tree_cb("tabnew") },
    -- { key = "<",                            cb = tree_cb("prev_sibling") },
    -- { key = ">",                            cb = tree_cb("next_sibling") },
    { key = "P",                            cb = tree_cb("parent_node") },
    { key = "<S-TAB>",                         cb = tree_cb("close_node") },
    { key = "<S-CR>",                       cb = tree_cb("close_node") },
    { key = "<Tab>",                        cb = tree_cb("preview") },
    { key = "K",                            cb = tree_cb("first_sibling") },
    { key = "J",                            cb = tree_cb("last_sibling") },
    { key = "I",                            cb = tree_cb("toggle_ignored") },
    { key = "H",                            cb = tree_cb("toggle_dotfiles") },
    { key = "R",                            cb = tree_cb("refresh") },
    { key = "n",                            cb = tree_cb("create") },
    { key = "d",                            cb = tree_cb("remove") },
    { key = "r",                            cb = tree_cb("rename") },
    { key = "<C-r>",                        cb = tree_cb("full_rename") },
    { key = "x",                            cb = tree_cb("cut") },
    { key = "c",                            cb = tree_cb("copy") },
    { key = "p",                            cb = tree_cb("paste") },
    { key = "y",                            cb = tree_cb("copy_name") },
    { key = "Y",                            cb = tree_cb("copy_path") },
    { key = "gy",                           cb = tree_cb("copy_absolute_path") },
    { key = "[c",                           cb = tree_cb("prev_git_item") },
    { key = "]c",                           cb = tree_cb("next_git_item") },
    { key = "-",                            cb = tree_cb("dir_up") },
    { key = "q",                            cb = tree_cb("close") },
    { key = "g?",                           cb = tree_cb("toggle_help") },
  }

  local utils = require 'utils'
  utils.set_keymap("n", "<F1>", "<CMD>NvimTreeToggle<CR>", { noremap = true, silent = true })
end

return M

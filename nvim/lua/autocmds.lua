local M = {}

local default_autogroups = {
  _general_settings = {
    -- Stop newline continution of comments
    {
      "FileType",
      "*",
      "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
    },
    -- Highlighting yarked region
    {
      "TextYankPost",
      "*",
      "lua require('vim.highlight').on_yank({ higroup = 'HighlightedYankRegion', timeout = 1000 })",
    },
    {
      "ColorScheme",
      "*",
      "highlight HighlightedYankRegion gui=reverse",
    },
    -- Exclude qf in the buffer list
    {
      "FileType",
      "qf",
      "set nobuflisted",
    },
    {
      "FileType",
      "qf",
      "nnoremap <silent> <buffer> q :q<CR>",
    },
    {
      "FileType",
      "help",
      "nnoremap <silent> <buffer> q :q<CR>",
    },
  },
  _markdown = {
    { "FileType", "markdown", "setlocal wrap" },
    { "FileType", "markdown", "setlocal spell" },
  },
  _general_lsp = {
    {
      "FileType",
      "lspinfo",
      "nnoremap <silent> <buffer> q :q<CR>",
    },
  },
}

function M.define_augroups(definitions)
  -- Create autocommand groups based on the passed definitions
  --
  -- The key will be the name of the group, and each definition
  -- within the group should have:
  --    1. Trigger
  --    2. Pattern
  --    3. Text
  -- just like how they would normally be defined from Vim itself
  for group_name, definition in pairs(definitions) do
    vim.cmd("augroup " .. group_name)
    vim.cmd "autocmd!"

    for _, def in pairs(definition) do
      local command = table.concat(vim.tbl_flatten { "autocmd", def }, " ")
      vim.cmd(command)
    end

    vim.cmd "augroup END"
  end
end

function M.setup()
  M.define_augroups(default_autogroups)
end

return M
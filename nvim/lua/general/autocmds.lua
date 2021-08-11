local M = {}

local default_autogroups = {
  _general_settings = {
    -- File in ftplugin/*.lua or after/ftplugin/*.lua will now get automatically run at the correct time
    -- TODO: Remove after neovim support this feature
    {
      "Filetype",
      "*",
      "lua require('utils.ftplugin').do_filetype(vim.fn.expand(\"<amatch>\"))",
    },
    -- Stop newline continution of comments
    {
      "FileType",
      "*",
      "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
    },
    -- When a file has been detected to have been changed outside of Vim and it has not been changed inside of Vim, automatically read it again
    {
      "FocusGained, BufEnter",
      "*",
      ":checktime",
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
  },
  _general_lsp = {
    {
      "FileType",
      "lspinfo",
      "nnoremap <silent> <buffer> q :q<CR>",
    },
  },
}

function M.define_default_autogroups()
  M.define_augroups(default_autogroups)
end

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

return M

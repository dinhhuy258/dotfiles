local M = {}

local options = {
  shell = "/bin/zsh", -- Shell
  fileencoding = "utf-8", -- File-content encoding for the current buffe
  fileencodings = "utf-8", -- This is a list of character encodings considered when starting to edit an existing file. Note that 'fileencodings' is not used for a new file, the global value of 'fileencoding' is used instead
  backspace = "indent,eol,start", -- Allow backspace over indention, line breaks and insertion start
  tabstop = 2, -- Number of spaces that a <Tab> in the file counts for
  shiftwidth = 2, -- Number of spaces to use for each step of (auto)indent. Used for >>, <<, etc
  expandtab = true, -- Convert tabs to spaces
  smartindent = true, -- Do smart autoindenting when starting a new line
  autoindent = true, -- Copy indent from current line when starting a new line (typing <CR> in Insert mode or when using the "o" or "O" command)
  foldenable = false, -- Disable folding
  wrap = false, -- Display long lines as just one line
  scrolloff = 4, -- Minimal number of screen lines to keep above and below the cursor
  sidescrolloff = 4, -- The minimal number of screen columns to keep to the left and to the right of the cursor
  hlsearch = true, -- Highlight all matches on previous search pattern
  incsearch = true, -- While typing a search command, show where the pattern, as it was typed so far, matches
  ignorecase = true, -- Ignore case in search patterns
  smartcase = true, -- Override the 'ignorecase' option if the search pattern contains upper case characters
  number = true, -- Dislay line numbers
  numberwidth = 2, -- Set number column width to 2 (default 4)
  relativenumber = false, -- Disable relative number
  laststatus = 2, -- Always show status line (2 = always)
  showtabline = 2, -- Always show tabs (2 = always)
  hidden = true, -- Required to keep multiple buffers open multiple buffers
  backup = false, -- Disable backup file
  writebackup = false, -- If a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  swapfile = false, -- Disable swapfile
  cmdheight = 2, -- More space in the neovim command line for displaying messages
  updatetime = 300, -- Faster completion
  timeoutlen = 500, -- Time in milliseconds to wait for a mapped sequence to complete (Assuming you have two mappings: gc and gcc, when you pressed gc and stopped, neovim would wait timeoutlen to see if you want to trigger gc or just in the middle of gcc)
  signcolumn = "yes", -- Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved
  showmode = false, -- We don't need the see things like -- INSERT -- anymore
  splitbelow = true, -- Horizontal splits will automatically be below
  splitright = true, -- Vertical splits will automatically be to the right
  clipboard = "unnamedplus", -- Allows neovim to access the system clipboard
  guifont = "Hack Nerd Font", -- The font used in graphical neovim applications
  mouse = "a", -- Allow the mouse to be used in neovim
  cursorline = true, --  Highlight the current line
  completeopt = "menuone,noselect",
  background = "dark",
  termguicolors = true, -- Set term gui colors
  list = true,
  listchars = { -- Strings to use in 'list' mode
    tab = " ",
    eol = "¬",
  },
}

function M.setup()
  for k, v in pairs(options) do
    vim.opt[k] = v
  end

  vim.cmd "set shortmess+=c"
  vim.cmd "set iskeyword+=-" -- Treat dash separated words as a word text object
end

return M

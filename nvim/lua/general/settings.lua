-- Shell
vim.o.shell = "/bin/zsh"

-- Encoding
vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"
vim.o.fileencodings = "utf-8"

-- Allow backspacing over everything in insert mode
vim.o.backspace = "indent,eol,start"

-- Tab
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- Indent
vim.o.smartindent = true
vim.o.autoindent = true

-- Disable folding
vim.o.foldenable = false

-- Display long lines as just one line
vim.o.wrap = false

-- The minimal number of screen lines to keep above and below the cursor
vim.o.scrolloff = 4

-- The minimal number of screen columns to keep to the left and to the right of the cursor
vim.o.sidescrolloff = 4

-- Searching
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- Enables syntax highlighting
vim.cmd "syntax on"

-- Display line numbers
vim.o.number = true
vim.o.numberwidth = 4
vim.o.relativenumber = false

-- Show the cursor position
vim.o.ruler = true

-- Always show status bar (2 = always)
vim.o.laststatus = 2

-- Display hidden characters
vim.cmd "set listchars=tab:▸\\ ,eol:¬"
vim.o.list = true

-- Required to keep multiple buffers open multiple buffers
vim.o.hidden = true

-- Some LSP servers have issues with backup files
vim.o.backup = false
vim.o.writebackup = false

-- Giving more spaces for displaying messages
vim.o.cmdheight = 2

-- Faster completion
vim.o.updatetime = 300

-- Time in milliseconds to wait for a mapped sequence to complete
vim.o.timeoutlen = 1000

-- Don't pass messages to |ins-completion-menu|
vim.cmd "set shortmess+=c"

-- Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved.
vim.o.signcolumn = "yes"

-- Treat dash separated words as a word text object
vim.cmd "set iskeyword+=-"

-- We don't need the see things like -- INSERT -- anymore
vim.o.showmode = false

-- Always show tabs (2 = always)
vim.o.showtabline = 2

-- Horizontal splits will automatically be below
vim.o.splitbelow = true

-- Vertical splits will automatically be to the right
vim.o.splitright = true

-- Disable swapfiles
vim.o.swapfile = false

-- Copy paste between vim and everything else
vim.o.clipboard = "unnamedplus"

-- Setting the font in the GUI
vim.o.guifont = "Hack Nerd Font"

-- Enable mouse
vim.o.mouse = "a"

-- Enable cursorline
vim.o.cursorline = true

-- Session manager
vim.g.session_directory = "~/.config/nvim/session"
vim.g.session_autoload = "no"
vim.g.session_autosave = "no"
vim.g.session_command_aliases = 1

-- Config variable for my plugins
vim.g.huy_duong_workspace = 1

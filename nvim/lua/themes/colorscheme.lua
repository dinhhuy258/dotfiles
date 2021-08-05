-- vim.cmd "colorscheme iceberg"
vim.cmd "set termguicolors"

-- Tell vim what the background color looks like
vim.o.background = "dark"

vim.cmd "highlight HighlightedYankRegion cterm=reverse gui=reverse"
vim.cmd "highlight clear SignColumn"
vim.cmd "highlight LineNr ctermbg=NONE guibg=NONE"

vim.cmd "au ColorScheme * hi Normal ctermbg=none guibg=none"
vim.cmd "au ColorScheme * hi SignColumn ctermbg=none guibg=none"
vim.cmd "au ColorScheme * hi NormalNC ctermbg=none guibg=none"
vim.cmd "au ColorScheme * hi MsgArea ctermbg=none guibg=none"
vim.cmd "au ColorScheme * hi NvimTreeNormal ctermbg=none guibg=none"
vim.cmd "let &fcs='eob: '"

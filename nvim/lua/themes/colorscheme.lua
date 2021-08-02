vim.cmd('colorscheme iceberg')
vim.cmd('set termguicolors')

-- Tell vim what the background color looks like
vim.o.background = 'dark'

vim.cmd('highlight clear SignColumn')
vim.cmd('highlight Normal guibg=NONE ctermbg=NONE')
vim.cmd('highlight EndOfBuffer guibg=NONE ctermbg=NONE')
vim.cmd('highlight NonText guibg=NONE ctermbg=NONE')
vim.cmd('highlight CursorLineNR guibg=NONE ctermbg=NONE')
vim.cmd('highlight Comment cterm=italic')
vim.cmd('highlight HighlightedYankRegion cterm=reverse gui=reverse')
vim.cmd('highlight LineNr ctermbg=NONE guibg=NONE')

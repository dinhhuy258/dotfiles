colorscheme iceberg

highlight Normal guibg=NONE ctermbg=NONE
highlight EndOfBuffer guibg=NONE ctermbg=NONE
highlight NonText guibg=NONE ctermbg=NONE
highlight CursorLineNR guibg=NONE ctermbg=NONE
highlight Comment cterm=italic
highlight Yank cterm=reverse gui=reverse

if (has("termguicolors"))
    set termguicolors
    highlight LineNr ctermbg=NONE guibg=NONE
endif


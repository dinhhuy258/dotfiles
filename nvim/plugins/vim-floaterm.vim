let g:floaterm_gitcommit='floaterm'
let g:floaterm_autoinsert=1
let g:floaterm_autoclose=1
let g:floaterm_winblend=0
let g:floaterm_width=0.8
let g:floaterm_height=0.8
let g:floaterm_wintitle=0

nnoremap <Leader>tn :FloatermNew<CR>
tnoremap <Leader>tn <C-\><C-n>:FloatermNew<CR>
nnoremap <Leader>th :FloatermPrev<CR>
tnoremap <Leader>th <C-\><C-n>:FloatermPrev<CR>
nnoremap <Leader>tl :FloatermNext<CR>
tnoremap <Leader>tl <C-\><C-n>:FloatermNext<CR>
nnoremap <Leader>tt :FloatermToggle<CR>
tnoremap <Leader>tt <C-\><C-n>:FloatermToggle<CR>
nnoremap <Leader>tg :FloatermNew lazygit<CR>
tnoremap <Leader>tg <C-\><C-n>:FloatermNew lazygit<CR>


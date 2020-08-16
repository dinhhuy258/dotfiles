let g:floaterm_gitcommit='floaterm'
let g:floaterm_autoinsert=1
let g:floaterm_autoclose=1
let g:floaterm_winblend=0
let g:floaterm_width=0.8
let g:floaterm_height=0.8
let g:floaterm_wintitle=1

nnoremap <Leader>tc :FloatermNew<CR>
tnoremap <Leader>tc <C-\><C-n>:FloatermNew<CR>
nnoremap <Leader>tk :FloatermKill<CR>
tnoremap <Leader>tk <C-\><C-n>:FloatermKill<CR>
nnoremap <Leader>tp :FloatermPrev<CR>
tnoremap <Leader>tp <C-\><C-n>:FloatermPrev<CR>
nnoremap <Leader>tn :FloatermNext<CR>
tnoremap <Leader>tn <C-\><C-n>:FloatermNext<CR>
nnoremap <Leader>tt :FloatermToggle<CR>
tnoremap <Leader>tt <C-\><C-n>:FloatermToggle<CR>
nnoremap <Leader>tg :FloatermNew lazygit<CR>
tnoremap <Leader>tg <C-\><C-n>:FloatermNew lazygit<CR>


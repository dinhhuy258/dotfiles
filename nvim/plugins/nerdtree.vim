let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeQuitOnOpen = 1
" Automatically delete the buffer of the file you just deleted with NERDTree
let g:NERDTreeAutoDeleteBuffer = 1

" Toggle NERDTree 
nnoremap <silent> <F1> :NERDTreeToggle<CR>
" Reveal the file in the NERDTree
nnoremap <silent> <F2> :NERDTreeFind<CR>

" " Open a NERDTree automatically when vim starts up
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif


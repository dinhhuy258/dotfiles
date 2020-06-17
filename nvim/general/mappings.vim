" Change leader key to space
let mapleader = "\<Space>"

" Reload vim configuration
nnoremap <Leader>rl :so ~/.config/nvim/init.vim<cr>

" Split
noremap <Leader>- :<C-u>split<CR>
noremap <Leader>\ :<C-u>vsplit<CR>

" Clean search (highlight)
nnoremap <silent> <Leader><space> :noh<CR>

" Alternate way to save
nnoremap <C-s> :w<CR>

" Alternate way to quit
nnoremap <C-q> :wq!<CR>


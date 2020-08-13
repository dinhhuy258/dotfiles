" Change leader key to semicolon
let mapleader = ";"

" Reload vim configuration
nnoremap <Leader>rl :so ~/.config/nvim/init.vim<cr>

" Split
noremap <Leader>- :<C-u>split<CR>
noremap <Leader>\ :<C-u>vsplit<CR>

" Clean search (highlight)
nnoremap <silent> <Leader>; :noh<CR>

" Alternate way to save
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>

" Alternate way to quit
nnoremap <C-q> :wq!<CR>

" Alternate way to copy
xnoremap <C-c> y<CR>

" Alternate way to paste
nnoremap <C-v> P<CR>
inoremap <C-v> <Esc>p<CR>

" Next buffer
nnoremap <silent> <Leader>] :bnext<CR>
nnoremap <silent> <Leader>[ :bprev<CR>
nnoremap <silent> <Leader>w :bd<CR>
nnoremap <silent> <Leader>W :bd!<CR>

" Abbreviations
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall


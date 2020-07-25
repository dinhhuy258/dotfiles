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
nnoremap <Leader>] :bnext<CR>
nnoremap <Leader>[ :bprev<CR>
nnoremap <Leader>w :bd<CR>
nnoremap <Leader>W :bd!<CR>

" Delete without putting into the registers
nnoremap dd "_dd
nnoremap dw "_dw
nnoremap db "_db
nnoremap di" "_di"
nnoremap da" "_da"
nnoremap di' "_di'
nnoremap da' "_da'
nnoremap di( "_di(
nnoremap di) "_di)
nnoremap da( "_da(
nnoremap da) "_da)
nnoremap di[ "_di[
nnoremap di] "_di]
nnoremap da[ "_da[
nnoremap da] "_da]
nnoremap di{ "_di{
nnoremap di} "_di}
nnoremap da{ "_da{
nnoremap da} "_da}
nnoremap de "_de
nnoremap dG "_dG
nnoremap dgg "_dgg
nnoremap d$ "_d$
nnoremap d^ "_d^
nnoremap d0 "_d0
nnoremap D "_D
nnoremap x "_x
nnoremap X "_X
vnoremap d "_d
vnoremap D "_D

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


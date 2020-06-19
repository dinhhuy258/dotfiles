set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

nnoremap <silent> <Leader>ff :FZF -m<CR>
nnoremap <silent> <Leader>ft :Ag<CR>
nnoremap <silent> <Leader>fg :GFiles<CR>
nnoremap <silent> <Leader>fb :Buffers<CR>


let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#show_number = 2
let g:lightline#bufferline#enable_devicons = 0
let g:lightline#bufferline#unicode_symbols = 1
let g:lightline#bufferline#clickable = 1

function! s:GoToLastBuffer() abort
  call lightline#bufferline#go(len(getbufinfo({'buflisted':1})))
endfunction

nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <silent> <Leader>0 :call <SID>GoToLastBuffer()<CR>

imap <Leader>1 <Esc><Plug>lightline#bufferline#go(1)
imap <Leader>2 <Esc><Plug>lightline#bufferline#go(2)
imap <Leader>3 <Esc><Plug>lightline#bufferline#go(3)
imap <Leader>4 <Esc><Plug>lightline#bufferline#go(4)
imap <Leader>5 <Esc><Plug>lightline#bufferline#go(5)
imap <Leader>6 <Esc><Plug>lightline#bufferline#go(6)
imap <Leader>7 <Esc><Plug>lightline#bufferline#go(7)
imap <Leader>8 <Esc><Plug>lightline#bufferline#go(8)
imap <Leader>9 <Esc><Plug>lightline#bufferline#go(9)
imap <silent> <Leader>0 <Esc>:call <SID>GoToLastBuffer()<CR>


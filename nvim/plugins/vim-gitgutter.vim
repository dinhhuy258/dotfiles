highlight clear SignColumn
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=yellow
highlight GitGutterDelete ctermfg=red
highlight GitGutterChangeDelete ctermfg=yellow

function! s:GitGutterNextHunkCycle() abort
  let line = line('.')
  silent! GitGutterNextHunk
  if line('.') == line
    1
    GitGutterNextHunk
  endif
endfunction

function! s:GitGutterPrevHunkCycle() abort
  let line = line('.')
  silent! GitGutterPrevHunk
  if line('.') == line
    $
    GitGutterPrevHunk
  endif
endfunction

nmap ghv <Plug>(GitGutterPreviewHunk)
nmap <silent> ghp :call <SID>GitGutterPrevHunkCycle()<CR>
nmap <silent> ghn :call <SID>GitGutterNextHunkCycle()<CR>
nmap ghu <Plug>(GitGutterUndoHunk)


let loaded_settings_plugins_lightline = 1

function! DrawGitBranchInfo()
  let branch = fugitive#head()
  return len(branch) > 0 ? " " . branch : ""
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() : '') : ''
endfunction

function! LightLineFilename()
  let name = ""
  let subs = split(expand('%'), "/")
  let i = 1
  for s in subs
    let parent = name
    if  i == len(subs)
      let name = len(parent) > 0 ? parent . '/' . s : s
    elseif i == 1
      let name = s
    else
      let part = strpart(s, 0, 10)
      let name = len(parent) > 0 ? parent . '/' . part : part
    endif
    let i += 1
  endfor
  return DecorateFileNameIfReadonly(name)
endfunction

function! DrawReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ":lock:"
  else
    return ""
  endif
endfunction

function! DecorateFileNameIfReadonly(name)
  return ('' != DrawReadonly() ? DrawReadonly() . ' ' : '') .
        \ ('' != expand('%') ? expand('%') : '[NoName]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineGitGutter()
  if ! exists('*GitGutterGetHunkSummary')
        \ || ! get(g:, 'gitgutter_enabled', 0)
        \ || winwidth('.') <= 90
    return ''
  endif
  let symbols = [
        \ g:gitgutter_sign_added,
        \ g:gitgutter_sign_modified,
        \ g:gitgutter_sign_removed
        \ ]
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in [0, 1, 2]
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
    endif
  endfor
  return join(ret, ' ')
endfunction

function! LightLineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

let g:lightline = {
      \ 'active': {
      \   'left': [
      \      ['fileicon'],
      \      ['cocstatus'],
      \      ['filename'],
      \   ],
      \   'right': [
      \      ['readonly'],
      \      ['icongitbranch'],
      \      ['gitgutter'],
      \      ['lineinfo']
      \   ]
      \ },
      \ 'inactive': {
      \   'left': [ [], ['fileicon'], [ 'filename' ] ],
      \   'right': []
      \ },
      \ 'component': { 'lineinfo': ' %2p%% %3l/%L:%-2v' },
      \ 'component_function': {
      \   'fileicon': 'MyFiletype',
      \   'icongitbranch': 'DrawGitBranchInfo',
      \   'cocstatus': 'coc#status',
      \   'filename': 'LightLineFilename',
      \   'readonly': 'DrawReadOnly',
      \   'gitgutter': 'LightLineGitGutter',
      \   'modified': 'LightLineModified',
      \ },
      \ 'separator': { 'left': '▓▒░', 'right': '░▒▓' },
      \ 'subseparator': { 'left': '>', 'right': '⮃' }
      \ }

" Use autocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()


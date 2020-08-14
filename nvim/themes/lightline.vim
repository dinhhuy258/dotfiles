let loaded_settings_plugins_lightline = 1
let s:icons_cache = {}

function! GetFileIcon() abort
  if empty(&filetype)
    return
  endif

  if has_key(s:icons_cache, &filetype)
    return get(s:icons_cache, &filetype)
  endif

  let l:icon = WebDevIconsGetFileTypeSymbol()
  let s:icons_cache[&filetype] = l:icon

  return l:icon
endfunction

function! GetFileName() abort
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

  return name
endfunction

let g:lightline = {
      \ 'colorscheme': 'icebergDark',
      \ 'active': {
      \   'left': [
      \      ['fileicon'],
      \      ['cocstatus'],
      \      ['filename'],
      \   ],
      \   'right': [
      \      ['lineinfo']
      \   ]
      \ },
      \ 'tabline': {
      \   'left': [
      \      ['buffers']
      \   ],
      \   'right': [
      \   ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ },
      \ 'component_raw': {
      \   'buffers': 1
      \ },
      \ 'inactive': {
      \   'left': [ [], ['fileicon'], [ 'filename' ] ],
      \   'right': []
      \ },
      \ 'component': { 'lineinfo': '%2p%% %3l/%L:%-2v' },
      \ 'component_function': {
      \   'fileicon': 'GetFileIcon',
      \   'cocstatus': 'coc#status',
      \   'filename': 'GetFileName',
      \ },
      \ }

" Use autocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()


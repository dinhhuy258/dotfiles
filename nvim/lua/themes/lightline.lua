vim.cmd('let g:lightline_icons_cache = {}')

vim.api.nvim_exec(
  [[

    function! GetFileIcon() abort
      if empty(&filetype)
        return
      endif

      if has_key(g:lightline_icons_cache, &filetype)
        return get(g:lightline_icons_cache, &filetype)
      endif

      let l:icon = WebDevIconsGetFileTypeSymbol()
      let g:lightline_icons_cache[&filetype] = l:icon

      return l:icon
    endfunction

  ]],
  ""
)

vim.g.lightline = {
  [ 'colorscheme' ] = 'vim_utilities',
  [ 'active' ] = {
    [ 'left' ] = {
      { 'fileicon' },
      { 'relativepath' }
    },
    [ 'right' ] = {
      { 'lineinfo' }
    }
  },
  [ 'inactive' ] = {
    [ 'left' ] = {
      { 'fileicon' },
      { 'relativepath' }
    },
    [ 'right' ] = {}
  },
  [ 'tabline' ] = {
    [ 'left' ] = {
      { 'buffers' }
    },
    [ 'right' ] = {}
  },
  [ 'component_expand' ] = {
    [ 'buffers' ] = 'lightline#bufferline#buffers'
  },
  [ 'component_type' ] = {
    [ 'buffers' ] = 'tabsel'
  },
  [ 'component_raw' ] = {
    [ 'buffers' ] = 1
  },
  [ 'component' ] = {
    [ 'lineinfo' ] = '%2p%% %3l/%L:%-2v'
  },
  [ 'component_function' ] = {
    [ 'fileicon' ] = 'GetFileIcon'
  }
}


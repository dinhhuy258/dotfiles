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

    function! BuildPalette() abort
      let p = { 'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline':  {}}

      let col_base     = ['NONE', 'NONE', 'NONE', 'NONE']
      let col_edge     = ['#17171b', '#818596', 234, 245]
      let col_gradient = ['#6b7089', '#2e313f', 242, 236]
      let col_nc       = ['#3e445e', '#0f1117', 238, 233]
      let col_tabfill  = ['#3e445e', '#0f1117', 238, 233]
      let col_normal   = ['#17171b', '#818596', 234, 245]
      let col_error    = ['#161821', '#e27878', 234, 203]
      let col_warning  = ['#161821', '#e2a478', 234, 216]
      let col_insert   = ['#161821', '#84a0c6', 234, 110]
      let col_replace  = ['#161821', '#e2a478', 234, 216]
      let col_visual   = ['#161821', '#b4be82', 234, 150]
      let col_tabsel   = ['NONE', 'NONE', 'NONE', 'NONE']

      let p.normal.middle = [col_base]
      let p.normal.left = [col_normal, col_gradient]
      let p.normal.right = [col_edge, col_gradient]
      let p.normal.error = [col_error]
      let p.normal.warning = [col_warning]

      let p.insert.left = [col_insert, col_gradient]
      let p.replace.left = [col_replace, col_gradient]
      let p.visual.left = [col_visual, col_gradient]

      let p.inactive.middle = [col_base]
      let p.inactive.left = [col_nc, col_nc]
      let p.inactive.right = [col_nc, col_nc]

      return p
    endfunction

    let g:lightline#colorscheme#custom#palette = BuildPalette()

  ]],
  ""
)

vim.g.lightline = {
  [ 'colorscheme' ] = 'custom',
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
  [ 'component' ] = {
    [ 'lineinfo' ] = '%2p%% %3l/%L:%-2v'
  },
  [ 'component_function' ] = {
    [ 'fileicon' ] = 'GetFileIcon'
  }
}


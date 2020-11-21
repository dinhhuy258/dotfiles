vim.g.fzf_action = {
  [ 'enter' ] = 'edit',
  [ 'ctrl-h' ] = 'split',
  [ 'ctrl-v' ] = 'vsplit'
}

vim.g.fzf_history_dir = '~/.local/share/fzf-history'
vim.g.fzf_buffers_jump = 1

vim.g.fzf_layout = {
  [ 'up' ] = '~90%',
  [ 'window' ] = {
    [ 'width' ] = 0.8,
    [ 'height' ] = 0.8,
    [ 'yoffset' ] = 0.5,
    [ 'xoffset' ] =  0.5,
    [ 'border' ] = 'sharp'
  }
}

vim.g.fzf_preview_window = 'down:50%'

vim.g.fzf_colors = {
  [ 'fg' ] = { 'fg', 'Normal' },
  [ 'bg' ] = { 'bg', 'Normal' },
  [ 'hl' ] = { 'fg', 'Comment' },
  [ 'fg+' ] = { 'fg', 'CursorLine', 'CursorColumn', 'Normal' },
  [ 'bg+' ] = { 'bg', 'CursorLine', 'CursorColumn' },
  [ 'hl+' ] = { 'fg', 'Statement' },
  [ 'info' ] = { 'fg', 'PreProc' },
  [ 'border' ] = { 'fg', 'Ignore' },
  [ 'prompt' ] = { 'fg', 'Conditional' },
  [ 'pointer' ] = { 'fg', 'Exception' },
  [ 'marker' ] = { 'fg', 'Keyword' },
  [ 'spinner' ] = { 'fg', 'Label' },
  [ 'header' ] = { 'fg', 'Comment' }
}

vim.api.nvim_call_function("setenv", { 'FZF_DEFAULT_OPTS', '--layout=reverse --inline-info' })
vim.api.nvim_call_function("setenv", { 'FZF_DEFAULT_COMMAND', "rg --files --hidden --glob '!.git/**'" })

vim.api.nvim_exec(
  [[

    command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--inline-info']}, 'down:50%'), <bang>0)

    function! RipgrepFzf(query, fullscreen)
      let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
      let initial_command = printf(command_fmt, shellescape(a:query))
      let reload_command = printf(command_fmt, '{q}')
      let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
      call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec, 'down:50%'), a:fullscreen)
    endfunction

    command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

    nnoremap <silent> <Leader>fr :Rg<CR>
    nnoremap <silent> <Leader>fg :GFiles?<CR>
    nnoremap <silent> <Leader>fb :Buffers<CR>
    nnoremap <silent> <Leader>fm :Marks<CR>
    nnoremap <silent> <Leader>fe :History<CR>
    nnoremap <silent> <Leader>ff :Files<CR>

  ]],
  ""
)


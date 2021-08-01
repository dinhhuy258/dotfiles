local M = {}

function M.gitgutter_next_hunk_cycle()
  local line = vim.fn.line('.')
  vim.cmd('silent! GitGutterNextHunk')

  if vim.fn.line('.') == line then
    vim.cmd('1')
    vim.cmd('GitGutterNextHunk')
  end
end

function M.gitgutter_prev_hunk_cycle()
  local line = vim.fn.line('.')
  vim.cmd('silent! GitGutterPrevHunk')

  if vim.fn.line('.') == line then
    vim.cmd('$')
    vim.cmd('GitGutterPrevHunk')
  end
end

M.setup = function()
  vim.cmd('highlight GitGutterAdd ctermfg=green')
  vim.cmd('highlight GitGutterChange ctermfg=yellow')
  vim.cmd('highlight GitGutterDelete ctermfg=red')
  vim.cmd('highlight GitGutterChangeDelete ctermfg=yellow')

  local utils = require 'utils'
  utils.set_keymap('n', 'ghv', '<Plug>(GitGutterPreviewHunk)', { noremap = false })
  utils.set_keymap('n', 'ghu', '<Plug>(GitGutterUndoHunk)', { noremap = false })

  utils.set_keymap('n', 'ghn', '<CMD>lua require("plugins.vim-gitgutter").gitgutter_next_hunk_cycle()<CR>', { noremap = false })
  utils.set_keymap('n', 'ghp', '<CMD>lua require("plugins.vim-gitgutter").gitgutter_prev_hunk_cycle()<CR>', { noremap = false })
end

return M

local M = {}

function M.go_to_last_buffer()
  local last_buffer_index = vim.fn.len(vim.fn.getbufinfo({ [ 'buflisted' ] = 1 }))
  if last_buffer_index >= 0 then
  vim.call('lightline#bufferline#go', last_buffer_index)
  end
end

M.setup = function()
  vim.g["lightline#bufferline#filename_modifier"] = ':t'
  vim.g["lightline#bufferline#show_number"] = 2
  vim.g["lightline#bufferline#enable_devicons"] = 0
  vim.g["lightline#bufferline#unicode_symbols"] = 1
  vim.g["lightline#bufferline#clickable"] = 1

  local utils = require 'utils'

  utils.set_keymap('n', '<Leader>1', '<Plug>lightline#bufferline#go(1)', { noremap = false })
  utils.set_keymap('n', '<Leader>2', '<Plug>lightline#bufferline#go(2)', { noremap = false })
  utils.set_keymap('n', '<Leader>3', '<Plug>lightline#bufferline#go(3)', { noremap = false })
  utils.set_keymap('n', '<Leader>4', '<Plug>lightline#bufferline#go(4)', { noremap = false })
  utils.set_keymap('n', '<Leader>5', '<Plug>lightline#bufferline#go(5)', { noremap = false })
  utils.set_keymap('n', '<Leader>6', '<Plug>lightline#bufferline#go(6)', { noremap = false })
  utils.set_keymap('n', '<Leader>7', '<Plug>lightline#bufferline#go(7)', { noremap = false })
  utils.set_keymap('n', '<Leader>8', '<Plug>lightline#bufferline#go(8)', { noremap = false })
  utils.set_keymap('n', '<Leader>9', '<Plug>lightline#bufferline#go(9)', { noremap = false })
  utils.set_keymap('n', '<Leader>0', '<CMD>lua require("plugins.lightline-bufferline").go_to_last_buffer()<CR>', { noremap = false })

  utils.set_keymap('i', '<Leader>1', '<Esc><Plug>lightline#bufferline#go(1)', { noremap = false })
  utils.set_keymap('i', '<Leader>2', '<Esc><Plug>lightline#bufferline#go(2)', { noremap = false })
  utils.set_keymap('i', '<Leader>3', '<Esc><Plug>lightline#bufferline#go(3)', { noremap = false })
  utils.set_keymap('i', '<Leader>4', '<Esc><Plug>lightline#bufferline#go(4)', { noremap = false })
  utils.set_keymap('i', '<Leader>5', '<Esc><Plug>lightline#bufferline#go(5)', { noremap = false })
  utils.set_keymap('i', '<Leader>6', '<Esc><Plug>lightline#bufferline#go(6)', { noremap = false })
  utils.set_keymap('i', '<Leader>7', '<Esc><Plug>lightline#bufferline#go(7)', { noremap = false })
  utils.set_keymap('i', '<Leader>8', '<Esc><Plug>lightline#bufferline#go(8)', { noremap = false })
  utils.set_keymap('i', '<Leader>9', '<Esc><Plug>lightline#bufferline#go(9)', { noremap = false })
  utils.set_keymap('i', '<Leader>0', '<CMD>lua require("plugins.lightline-bufferline").go_to_last_buffer()<CR>', { noremap = false })
end

return M

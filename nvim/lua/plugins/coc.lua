local utils = require 'utils'

vim.g.coc_global_extensions = {
  'coc-pairs',
  'coc-prettier',
  'coc-tabnine',
  'coc-json',
  'coc-yaml',
  'coc-phpls',
  'coc-python',
  'coc-clangd',
  'coc-tsserver'
}

function _G.check_back_space()
  local col = vim.fn.col('.') - 1

  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

utils.set_keymap('i', '<TAB>', 'pumvisible() ? "<C-n>" : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', { noremap = true, expr = true })
utils.set_keymap('i', '<S-TAB>', 'pumvisible() ? "<C-p>" : "<C-h>"', { noremap = true, expr = true })

-- Use <c-space> to trigger completion
utils.set_keymap('i', '<c-space>', 'coc#refresh()', { noremap = true, expr = true })

-- User <CR> to select a suggestion
utils.set_keymap('i', '<CR>', 'pumvisible() ? coc#_select_confirm() : "<C-g>u<CR><C-r>=coc#on_enter()<CR>"', { noremap = true, expr = true })

-- Use `g[` and `g]` to navigate diagnostics
utils.set_keymap('n', 'g[', '<Plug>(coc-diagnostic-prev)', { noremap = false })
utils.set_keymap('n', 'g]', '<Plug>(coc-diagnostic-next)', { noremap = false })

-- Code navigation
utils.set_keymap('n', 'gd', '<Plug>(coc-definition)', { noremap = false })
utils.set_keymap('n', 'gy', '<Plug>(coc-type-definition)', { noremap = false })
utils.set_keymap('n', 'gi', '<Plug>(coc-implementation)', { noremap = false })
utils.set_keymap('n', 'gr', '<Plug>(coc-references)', { noremap = false })

-- Show documentation in preview window
function show_documentation()
  if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
    vim.cmd('h '.. vim.fn.expand('<cword>'))
  else
    vim.cmd('call CocAction("doHover")')
  end
end
utils.set_keymap('n', 'K', '<CMD>lua show_documentation()<CR>', { noremap = true })

-- Formatting selected code
utils.set_keymap('v', '<Leader>cl', '<Plug>(coc-format-selected)', { noremap = false })
utils.set_keymap('n', '<Leader>cl', '<Plug>(coc-format)', { noremap = false })

utils.set_keymap('n', '<Leader>cf', ':CocFix<CR>', { noremap = false })
utils.set_keymap('n', '<Leader>cc', ':CocFzfList<CR>', { noremap = false })


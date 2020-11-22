local utils = require 'utils'

-- Change leader key to semicolon
vim.g.mapleader = ";"

-- Disable keys
utils.set_keymap('n', 'Q', '<Nop>', { noremap = true })

-- Reload vim configuration
utils.set_keymap('n', '<Leader>rl', ":so ~/.config/nvim/init.vim<CR>", { noremap = true, silent = false })

-- Split
utils.set_keymap('n', '<Leader>-', ':<C-u>split<CR>', { noremap = true, silent = false })
utils.set_keymap('n', '<Leader>\\', ':<C-u>vsplit<CR>', { noremap = true, silent = false })

-- Alternate way to save
utils.set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = false })
utils.set_keymap('i', '<C-s>', '<Esc>:w<CR>', { noremap = true, silent = false })

-- Alternate way to quit
utils.set_keymap('n', '<C-q>', ':wq!<CR>', { noremap = true, silent = false })

-- Next buffer
utils.set_keymap('n', '<Leader>]', ':bnext<CR>', { noremap = true })
utils.set_keymap('n', '<Leader>[', ':bprev<CR>', { noremap = true })
utils.set_keymap('n', '<Leader>w', ':bd<CR>', { noremap = true })
utils.set_keymap('n', '<Leader>W', ':bd!<CR>', { noremap = true })

-- -- Abbreviations
vim.cmd('cnoreabbrev W! w!')
vim.cmd('cnoreabbrev Q! q!')
vim.cmd('cnoreabbrev Qall! qall!')
vim.cmd('cnoreabbrev Wq wq')
vim.cmd('cnoreabbrev Wa wa')
vim.cmd('cnoreabbrev wQ wq')
vim.cmd('cnoreabbrev WQ wq')
vim.cmd('cnoreabbrev W w')
vim.cmd('cnoreabbrev Q q')
vim.cmd('cnoreabbrev Qall qall')


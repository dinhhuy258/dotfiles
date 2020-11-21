local utils = require 'utils'

 -- Enable default mappings
vim.g.EasyMotion_do_mapping = 0

-- Turn on case-sensitive feature
vim.g.EasyMotion_smartcase = 1

utils.set_keymap('n', '<Leader><Leader>', '<Plug>(easymotion-s)', { noremap = false })


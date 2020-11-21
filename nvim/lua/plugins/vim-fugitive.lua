local utils = require 'utils'

utils.set_keymap('n', '<Leader>gs', ':Gstatus<CR>', { noremap = true })
utils.set_keymap('n', '<Leader>gb', ':Gblame<CR>', { noremap = true })
utils.set_keymap('n', '<Leader>gd', ':Gvdiff<CR>', { noremap = true })


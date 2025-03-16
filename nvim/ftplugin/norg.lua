local keymaps = require "config.keymaps"

keymaps.set("n", "<Leader>cf", "<CMD>normal! gg=G<CR>", { noremap = true, silent = true })

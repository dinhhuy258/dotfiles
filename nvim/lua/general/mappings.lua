local utils = require "utils"

-- Change leader key to semicolon
vim.g.mapleader = ";"

-- Disable keys
utils.set_keymap("n", "Q", "<Nop>", { noremap = true })

-- Split
utils.set_keymap("n", "<Leader>-", ":<C-u>split<CR>", { noremap = true, silent = false })
utils.set_keymap("n", "<Leader>\\", ":<C-u>vsplit<CR>", { noremap = true, silent = false })

-- Alternate way to save
utils.set_keymap("n", "<C-s>", ":w<CR>", { noremap = true, silent = false })
utils.set_keymap("i", "<C-s>", "<Esc>:w<CR>", { noremap = true, silent = false })

-- Alternate way to quit
utils.set_keymap("n", "<C-q>", ":wq!<CR>", { noremap = true, silent = false })

-- Vim move
utils.set_keymap("x", "<A-L>", ">gv", { noremap = true })
utils.set_keymap("x", "<A-H>", "<gv", { noremap = true })
utils.set_keymap("x", "<A-K>", ":move '<-2<CR>gv=gv", { noremap = true })
utils.set_keymap("x", "<A-J>", ":move '>+1<CR>gv=gv", { noremap = true })

utils.set_keymap("n", "<A-L>", ">>", { noremap = true })
utils.set_keymap("n", "<A-H>", "<<", { noremap = true })
utils.set_keymap("n", "<A-K>", ":move .-2<CR>", { noremap = true })
utils.set_keymap("n", "<A-J>", ":move .+1<CR>", { noremap = true })

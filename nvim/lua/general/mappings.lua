local utils = require "utils"

local M = {}

function M.setup()
  -- Change leader key to semicolon
  vim.g.mapleader = ";"

  -- Disable keys
  utils.set_keymap("n", "Q", "<Nop>")

  -- Split
  utils.set_keymap("n", "<Leader>-", ":<C-u>split<CR>")
  utils.set_keymap("n", "<Leader>\\", ":<C-u>vsplit<CR>")

  -- Alternate way to save
  utils.set_keymap("n", "<C-s>", ":w<CR>", { silent = false })
  utils.set_keymap("i", "<C-s>", "<Esc>:w<CR>", { silent = false })

  -- Alternate way to quit
  utils.set_keymap("n", "<C-q>", ":wq!<CR>", { silent = false })

  -- Vim move
  utils.set_keymap("x", "<A-L>", ">gv")
  utils.set_keymap("x", "<A-H>", "<gv")
  utils.set_keymap("x", "<A-K>", ":move '<-2<CR>gv=gv")
  utils.set_keymap("x", "<A-J>", ":move '>+1<CR>gv=gv")

  utils.set_keymap("n", "<A-L>", ">>")
  utils.set_keymap("n", "<A-H>", "<<")
  utils.set_keymap("n", "<A-K>", ":move .-2<CR>")
  utils.set_keymap("n", "<A-J>", ":move .+1<CR>")
end

return M

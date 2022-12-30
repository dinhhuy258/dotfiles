local utils = require "utils"

local M = {}

function M.setup()
  -- disable keys
  utils.set_keymap("n", "Q", "<Nop>")

  -- split
  utils.set_keymap("n", "<Leader>-", ":<C-u>split<CR>")
  utils.set_keymap("n", "<Leader>\\", ":<C-u>vsplit<CR>")

  -- alternate way to save
  utils.set_keymap("n", "<C-s>", ":w<CR>", { silent = false })
  utils.set_keymap("i", "<C-s>", "<Esc>:w<CR>", { silent = false })

  -- alternate way to quit
  utils.set_keymap("n", "<C-q>", ":wq!<CR>", { silent = false })

  -- close teminal
  utils.set_keymap("t", "<C-c>", "<C-\\><C-n>:q!<CR>", { silent = false })

  -- vim move
  utils.set_keymap("x", "<A-L>", ">gv")
  utils.set_keymap("x", "<A-H>", "<gv")
  utils.set_keymap("x", "<A-K>", ":move '<-2<CR>gv=gv")
  utils.set_keymap("x", "<A-J>", ":move '>+1<CR>gv=gv")

  utils.set_keymap("n", "<A-L>", ">>")
  utils.set_keymap("n", "<A-H>", "<<")
  utils.set_keymap("n", "<A-K>", ":move .-2<CR>")
  utils.set_keymap("n", "<A-J>", ":move .+1<CR>")

  -- copy
  utils.set_keymap("n", "cpf", ":let @+ = expand('%:p')<CR>", { silent = false })
  utils.set_keymap("n", "cpr", ":let @+ = fnamemodify(expand('%'), ':~:.')<CR>", { silent = false })
  utils.set_keymap("n", "cpg", ":let @+ = system('git rev-parse --abbrev-ref HEAD')<CR>", { silent = false })

  -- better navigation
  utils.set_keymap("n", "<Space>", "10j")
  utils.set_keymap("n", "<C-Space>", "10k")

  -- keep joinline cursor centerred
  utils.set_keymap("n", "J", "mzJ`z")

  -- undo break points
  utils.set_keymap("i", ",", ",<c-g>u")
  utils.set_keymap("i", ".", ".<c-g>u")
  utils.set_keymap("i", "!", "!<c-g>u")
  utils.set_keymap("i", "?", "?<c-g>u")
end

return M

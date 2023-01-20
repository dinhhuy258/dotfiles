local keymap = require "utils.keymap"

local M = {}

function M.setup()
  -- disable keys
  keymap.set("n", "Q", "<Nop>")

  -- split
  keymap.set("n", "<Leader>-", ":<C-u>split<CR>")
  keymap.set("n", "<Leader>\\", ":<C-u>vsplit<CR>")

  -- alternate way to save
  keymap.set("n", "<C-s>", ":w<CR>", { silent = false })
  keymap.set("i", "<C-s>", "<Esc>:w<CR>", { silent = false })

  -- alternate way to quit
  keymap.set("n", "<C-q>", ":wq!<CR>", { silent = false })

  -- close teminal
  keymap.set("t", "<C-c>", "<C-\\><C-n>:q!<CR>", { silent = false })

  -- vim move
  keymap.set("x", "<A-L>", ">gv")
  keymap.set("x", "<A-H>", "<gv")
  keymap.set("x", "<A-K>", ":move '<-2<CR>gv=gv")
  keymap.set("x", "<A-J>", ":move '>+1<CR>gv=gv")

  keymap.set("n", "<A-L>", ">>")
  keymap.set("n", "<A-H>", "<<")
  keymap.set("n", "<A-K>", ":move .-2<CR>")
  keymap.set("n", "<A-J>", ":move .+1<CR>")

  -- copy
  keymap.set("n", "cpf", ":let @+ = expand('%:p')<CR>", { silent = false })
  keymap.set("n", "cpr", ":let @+ = fnamemodify(expand('%'), ':~:.')<CR>", { silent = false })
  keymap.set("n", "cpg", ":let @+ = system('git rev-parse --abbrev-ref HEAD')<CR>", { silent = false })

  -- better navigation
  keymap.set("n", "<Space>", "10j")
  keymap.set("n", "<C-Space>", "10k")

  -- keep joinline cursor centerred
  keymap.set("n", "J", "mzJ`z")

  -- undo break points
  keymap.set("i", ",", ",<c-g>u")
  keymap.set("i", ".", ".<c-g>u")
  keymap.set("i", "!", "!<c-g>u")
  keymap.set("i", "?", "?<c-g>u")
end

return M

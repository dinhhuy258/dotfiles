local M = {}

function M.setup()
  -- disable keys
  M.set("n", "Q", "<Nop>")

  -- split
  M.set("n", "<Leader>-", ":<C-u>split<CR>")
  M.set("n", "<Leader>\\", ":<C-u>vsplit<CR>")

  -- alternate way to save
  M.set("n", "<C-s>", ":w<CR>", { silent = false })
  M.set("i", "<C-s>", "<Esc>:w<CR>", { silent = false })

  -- alternate way to quit
  M.set("n", "<C-q>", ":wq!<CR>", { silent = false })

  -- close teminal
  M.set("t", "<C-c>", "<C-\\><C-n>:q!<CR>", { silent = false })

  -- vim move
  M.set("x", "<A-L>", ">gv")
  M.set("x", "<A-H>", "<gv")
  M.set("x", "<A-K>", ":move '<-2<CR>gv=gv")
  M.set("x", "<A-J>", ":move '>+1<CR>gv=gv")

  M.set("n", "<A-L>", ">>")
  M.set("n", "<A-H>", "<<")
  M.set("n", "<A-K>", ":move .-2<CR>")
  M.set("n", "<A-J>", ":move .+1<CR>")

  -- copy
  M.set("n", "cpf", ":let @+ = expand('%:p')<CR>", { silent = false })
  M.set("n", "cpr", ":let @+ = fnamemodify(expand('%'), ':~:.')<CR>", { silent = false })
  M.set("n", "cpg", ":let @+ = system('git rev-parse --abbrev-ref HEAD')<CR>", { silent = false })

  -- better navigation
  M.set("n", "<Space>", "10j")
  M.set("n", "<C-Space>", "10k")

  -- keep joinline cursor centerred
  M.set("n", "J", "mzJ`z")

  -- undo break points
  M.set("i", ",", ",<c-g>u")
  M.set("i", ".", ".<c-g>u")
  M.set("i", ";", ";<c-g>u")
  M.set("i", "!", "!<c-g>u")
  M.set("i", "?", "?<c-g>u")

  -- better up/down
  M.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
  M.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

  -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
  M.set("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
  M.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
  M.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
  M.set("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
  M.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
  M.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

  -- allow to search in selection mode
  M.set({ "x" }, "/", "<Esc>/\\%V")

  -- better navigation in insert mode
  M.set({ "i" }, "<A-Right>", "<Esc>ea")
  M.set({ "i" }, "<A-Left>", "<Esc>bi")
end

function M.set(mode, lhs, rhs, opts)
  opts = vim.tbl_extend("force", {
    noremap = true,
    silent = true,
    expr = false,
  }, opts or {})

  vim.keymap.set(mode, lhs, rhs, opts)
end

return M

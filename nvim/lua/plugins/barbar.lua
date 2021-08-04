local M = {}

M.setup = function()
  local utils = require 'utils'

  utils.set_keymap("n", "<Left>", ":BufferPrevious<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Right>", ":BufferNext<CR>", { noremap = true, silent = true })

  utils.set_keymap("n", "<S-Left>", ":BufferMovePrevious<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<S-Right>", ":BufferMoveNext<CR>", { noremap = true, silent = true })

  utils.set_keymap("n", "<Leader>1", ":BufferGoto 1<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Leader>2", ":BufferGoto 2<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Leader>3", ":BufferGoto 3<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Leader>4", ":BufferGoto 4<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Leader>5", ":BufferGoto 5<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Leader>6", ":BufferGoto 6<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Leader>7", ":BufferGoto 7<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Leader>8", ":BufferGoto 8<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Leader>9", ":BufferGoto 9<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Leader>0", ":BufferLast<CR>", { noremap = true, silent = true })

  utils.set_keymap("i", "<Leader>1", "<ESC>:BufferGoto 1<CR>", { noremap = true, silent = true })
  utils.set_keymap("i", "<Leader>2", "<ESC>:BufferGoto 2<CR>", { noremap = true, silent = true })
  utils.set_keymap("i", "<Leader>3", "<ESC>:BufferGoto 3<CR>", { noremap = true, silent = true })
  utils.set_keymap("i", "<Leader>4", "<ESC>:BufferGoto 4<CR>", { noremap = true, silent = true })
  utils.set_keymap("i", "<Leader>5", "<ESC>:BufferGoto 5<CR>", { noremap = true, silent = true })
  utils.set_keymap("i", "<Leader>6", "<ESC>:BufferGoto 6<CR>", { noremap = true, silent = true })
  utils.set_keymap("i", "<Leader>7", "<ESC>:BufferGoto 7<CR>", { noremap = true, silent = true })
  utils.set_keymap("i", "<Leader>8", "<ESC>:BufferGoto 8<CR>", { noremap = true, silent = true })
  utils.set_keymap("i", "<Leader>9", "<ESC>:BufferGoto 9<CR>", { noremap = true, silent = true })
  utils.set_keymap("i", "<Leader>0", "<ESC>:BufferLast<CR>", { noremap = true, silent = true })

  utils.set_keymap("n", "<Leader>w", ":BufferClose<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Leader>x", ":BufferCloseAllButCurrent<CR>", { noremap = true, silent = true })

  utils.set_keymap("i", "<Leader>w", "<ESC>:BufferClose<CR>", { noremap = true, silent = true })
  utils.set_keymap("i", "<Leader>x", "<ESC>:BufferCloseAllButCurrent<CR>", { noremap = true, silent = true })

  utils.set_keymap("n", "<Leader>bb", ":BufferPin<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Leader>bp", ":BufferPick<CR>", { noremap = true, silent = true })

  vim.api.nvim_command("hi BufferCurrent       guibg=none guifg=none")
  vim.api.nvim_command("hi BufferCurrentMod    guibg=none guifg=none")
  vim.api.nvim_command("hi BufferCurrentIndex  guibg=none guifg=none")
  vim.api.nvim_command("hi BufferCurrentSign   guibg=none guifg=none")
  vim.api.nvim_command("hi BufferCurrentTarget guibg=none guifg=none")

  vim.api.nvim_command("hi BufferInactive      guibg=none guifg=#3e445e")
  vim.api.nvim_command("hi BufferInactiveIndex guibg=none guifg=#3e445e")
  vim.api.nvim_command("hi BufferInactiveSign  guibg=none guifg=#3e445e")
  vim.api.nvim_command("hi BufferInactiveMod   guibg=none guifg=#3e445e")
  vim.api.nvim_command("hi BufferTabpageFill   guibg=none guifg=#3e445e")
end

return M

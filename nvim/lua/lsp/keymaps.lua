local keymaps = require "config.keymaps"

local M = {}

function M.setup(bufnr)
  local opts = { buffer = bufnr }

  -- Navigation
  keymaps.set("n", "gd", "<CMD>lua require('telescope.builtin').lsp_definitions()<CR>", opts)
  keymaps.set("n", "gr", "<CMD>lua require('telescope.builtin').lsp_references()<CR>", opts)
  keymaps.set("n", "gi", "<CMD>lua require('telescope.builtin').lsp_implementations()<CR>", opts)
  keymaps.set("n", "gy", "<CMD>lua require('telescope.builtin').lsp_type_definitions()<CR>", opts)

  -- Code actions
  keymaps.set("n", "<Leader>ca", "<CMD>lua vim.lsp.buf.code_action()<CR>", opts)
  keymaps.set("n", "<Leader>cr", "<CMD>lua vim.lsp.buf.rename()<CR>", opts)

  -- Diagnostics navigation
  keymaps.set("n", "gnN", function()
    vim.diagnostic.jump {
      count = -1,
      float = true,
    }
  end, opts)

  keymaps.set("n", "gnn", function()
    vim.diagnostic.jump {
      count = 1,
      float = true,
    }
  end, opts)

  keymaps.set("n", "gno", "<CMD>lua vim.diagnostic.open_float({ border = 'rounded' })<CR>", opts)

  -- Hover and signature help with rounded borders
  keymaps.set("n", "K", function()
    vim.lsp.buf.hover { border = "rounded" }
  end, opts)

  keymaps.set("n", "<C-k>", function()
    vim.lsp.buf.signature_help { border = "rounded" }
  end, opts)

  -- Inlay hints toggle
  keymaps.set("n", "<Leader>hh", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }, { bufnr = bufnr })
  end, opts)

  -- Go-specific formatting (if needed)
  if vim.bo[bufnr].filetype == "go" then
    keymaps.set(
      "n",
      "<Leader>cf",
      "<CMD>lua require('go.format').format()<CR>",
      { noremap = true, silent = true, buffer = bufnr }
    )
  end
end

return M

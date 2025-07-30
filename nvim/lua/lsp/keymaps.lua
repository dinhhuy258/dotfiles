-- LSP keybindings setup
local M = {}

function M.setup()
  -- No global keymaps here - they're set up in autocmds.lua on LspAttach
  -- This module can be used for any LSP-related keymap utilities if needed
end

-- Function to set up buffer-local LSP keymaps
function M.setup_buffer_keymaps(client, bufnr)
  local opts = { buffer = bufnr, silent = true }
  
  -- Navigation
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
  vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Go to references" }))
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
  vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Go to type definition" }))
  
  -- Actions
  vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
  vim.keymap.set("n", "<Leader>cr", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
  vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
  
  -- Diagnostics with modern API
  vim.keymap.set("n", "gnn", function()
    vim.diagnostic.jump({ count = 1, float = true })
  end, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
  
  vim.keymap.set("n", "gnN", function()
    vim.diagnostic.jump({ count = -1, float = true })
  end, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
  
  vim.keymap.set("n", "gno", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Open diagnostic float" }))
  
  -- Enhanced diagnostic navigation
  vim.keymap.set("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = { border = "rounded" } })
  end, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))

  vim.keymap.set("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = { border = "rounded" } })
  end, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))

  vim.keymap.set("n", "]e", function()
    vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
  end, vim.tbl_extend("force", opts, { desc = "Next error" }))

  vim.keymap.set("n", "[e", function()
    vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
  end, vim.tbl_extend("force", opts, { desc = "Previous error" }))
  
  -- Inlay hints toggle with per-buffer control
  vim.keymap.set("n", "<Leader>hh", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
  end, vim.tbl_extend("force", opts, { desc = "Toggle inlay hints" }))

  -- Diagnostic lists
  vim.keymap.set("n", "<leader>q", vim.diagnostic.setqflist, vim.tbl_extend("force", opts, { desc = "Diagnostics quickfix" }))
  vim.keymap.set("n", "<leader>l", vim.diagnostic.setloclist, vim.tbl_extend("force", opts, { desc = "Diagnostics loclist" }))
  
  -- Completion trigger (if completion is enabled)
  vim.keymap.set('i', '<c-space>', function()
    vim.lsp.completion.get()
  end, vim.tbl_extend("force", opts, { desc = "Trigger completion" }))
end

return M
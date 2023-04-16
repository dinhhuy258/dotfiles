local keymap = require "utils.keymap"

local M = {}

local function lsp_keybindings(bufnr)
  local opts = { noremap = true, silent = true }

  keymap.buf_set(bufnr, "n", "gd", "<CMD>lua require('telescope.builtin').lsp_definitions()<CR>", opts)
  keymap.buf_set(bufnr, "n", "gr", "<CMD>lua require('telescope.builtin').lsp_references()<CR>", opts)
  keymap.buf_set(bufnr, "n", "gi", "<CMD>lua require('telescope.builtin').lsp_implementations()<CR>", opts)
  keymap.buf_set(bufnr, "n", "gy", "<CMD>lua require('telescope.builtin').lsp_type_definitions()<CR>", opts)
  keymap.buf_set(bufnr, "n", "<Leader>ca", "<CMD>lua vim.lsp.buf.code_action()<CR>", opts)

  keymap.buf_set(bufnr, "n", "g[", "<CMD>lua vim.diagnostic.goto_prev({ float = { border = 'rounded' } })<CR>", opts)
  keymap.buf_set(bufnr, "n", "g]", "<CMD>lua vim.diagnostic.goto_next({ float = { border = 'rounded' } })<CR>", opts)
  keymap.buf_set(bufnr, "n", "gl", "<CMD>lua vim.diagnostic.open_float({ border = 'rounded' })<CR>", opts)

  if require("utilities.formatter").is_supported(vim.bo.filetype) then
    keymap.buf_set(bufnr, "n", "<Leader>cf", "<CMD>lua require('utilities.formatter').format()<CR>", opts)
  else
    keymap.buf_set(bufnr, "n", "<Leader>cf", "<CMD>lua vim.lsp.buf.format()<CR>", opts)
  end
  keymap.buf_set(bufnr, "n", "<Leader>cr", "<CMD>lua vim.lsp.buf.rename()<CR>", opts)
  keymap.buf_set(bufnr, "n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>", opts)

  if vim.bo.filetype == "go" then
    keymap.buf_set(
      bufnr,
      "n",
      "<Leader>cf",
      "<CMD>lua require('go-tools.format').format()<CR>",
      { noremap = true, silent = true }
    )
  end
end

function M.common_on_init(client, _)
  if require("utilities.formatter").is_supported(vim.bo.filetype) or vim.bo.filetype == "go" then
    client.server_capabilities.document_formatting = false
  end
end

function M.common_capabilities()
  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    return cmp_nvim_lsp.default_capabilities()
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  return capabilities
end

function M.common_on_attach(_, bufnr)
  lsp_keybindings(bufnr)

  require("lsp_signature").on_attach {
    hint_enable = false,
    hi_parameter = "Underlined",
  }
end

function M.setup()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = true,
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

return M

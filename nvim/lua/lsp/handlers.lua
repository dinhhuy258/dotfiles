local navbuddy = require "nvim-navbuddy"
local keymaps = require "config.keymaps"
local icons = require "icons"

local M = {}

local function lsp_keybindings(bufnr)
  local opts = { buffer = bufnr }

  keymaps.set("n", "gd", "<CMD>lua require('telescope.builtin').lsp_definitions()<CR>", opts)
  keymaps.set("n", "gr", "<CMD>lua require('telescope.builtin').lsp_references()<CR>", opts)
  keymaps.set("n", "gi", "<CMD>lua require('telescope.builtin').lsp_implementations()<CR>", opts)
  keymaps.set("n", "gy", "<CMD>lua require('telescope.builtin').lsp_type_definitions()<CR>", opts)
  keymaps.set("n", "<Leader>ca", "<CMD>lua vim.lsp.buf.code_action()<CR>", opts)

  keymaps.set("n", "gnN", "<CMD>lua vim.diagnostic.goto_prev({ float = { border = 'rounded' } })<CR>", opts)
  keymaps.set("n", "gnn", "<CMD>lua vim.diagnostic.goto_next({ float = { border = 'rounded' } })<CR>", opts)
  keymaps.set("n", "gno", "<CMD>lua vim.diagnostic.open_float({ border = 'rounded' })<CR>", opts)

  keymaps.set("n", "<Leader>cr", "<CMD>lua vim.lsp.buf.rename()<CR>", opts)
  keymaps.set("n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>", opts)
  keymaps.set("n", "<Leader>hh", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, opts)

  if vim.bo.filetype == "go" then
    keymaps.set("n", "<Leader>cf", "<CMD>lua require('go.format').format()<CR>", { noremap = true, silent = true })
  end
end

function M.common_on_init(client, _)
  if vim.bo.filetype == "go" then
    client.server_capabilities.document_formatting = false
  end
end

function M.common_capabilities()
  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    return cmp_nvim_lsp.default_capabilities()
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
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

function M.common_on_attach(client, bufnr)
  lsp_keybindings(bufnr)

  require("lsp_signature").on_attach {
    hint_enable = false,
    hi_parameter = "Underlined",
  }

  navbuddy.attach(client, bufnr)
end

function M.setup()
  vim.diagnostic.config {
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = icons.diagnostics.error,
        [vim.diagnostic.severity.WARN] = icons.diagnostics.warning,
        [vim.diagnostic.severity.INFO] = icons.diagnostics.info,
        [vim.diagnostic.severity.HINT] = icons.diagnostics.hint,
      },
    },
  }

  local config = {
    virtual_text = true,
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

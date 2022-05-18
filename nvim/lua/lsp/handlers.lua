local utils = require "utils"
local M = {}

local function lsp_keybindings(bufnr)
  local opts = { noremap = true, silent = true }

  utils.buf_set_keymap(
    bufnr,
    "n",
    "gd",
    "<CMD>lua require('fzf-lua').lsp_definitions({ jump_to_single_result = true })<CR>",
    opts
  )
  utils.buf_set_keymap(
    bufnr,
    "n",
    "gD",
    "<CMD>lua require('fzf-lua').lsp_declarations({ jump_to_single_result = true })<CR>",
    opts
  )
  utils.buf_set_keymap(
    bufnr,
    "n",
    "gr",
    "<CMD>lua require('fzf-lua').lsp_references({ jump_to_single_result = true })<CR>",
    opts
  )
  utils.buf_set_keymap(
    bufnr,
    "n",
    "gi",
    "<CMD>lua require('fzf-lua').lsp_implementations({ jump_to_single_result = true })<CR>",
    opts
  )
  utils.buf_set_keymap(
    bufnr,
    "n",
    "gy",
    "<CMD>lua require('fzf-lua').lsp_typedefs({ jump_to_single_result = true })<CR>",
    opts
  )
  utils.buf_set_keymap(bufnr, "n", "<Leader>co", "<CMD>lua require('fzf-lua').lsp_document_symbols()<CR>", opts)
  utils.buf_set_keymap(bufnr, "n", "<Leader>ca", "<CMD>CodeActionMenu<CR>", opts)

  utils.buf_set_keymap(bufnr, "n", "g[", "<CMD>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  utils.buf_set_keymap(bufnr, "n", "g]", "<CMD>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  utils.buf_set_keymap(
    bufnr,
    "n",
    "gl",
    "<CMD>lua vim.lsp.diagnostic.show_line_diagnostics({ border = 'rounded' })<CR>",
    opts
  )

  if require("utilities.formatter").is_supported(vim.bo.filetype) then
    utils.buf_set_keymap(bufnr, "n", "<Leader>cf", "<CMD>lua require('utilities.formatter').format()<CR>", opts)
  else
    utils.buf_set_keymap(bufnr, "n", "<Leader>cf", "<CMD>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  utils.buf_set_keymap(bufnr, "n", "<Leader>cr", "<CMD>lua vim.lsp.buf.rename()<CR>", opts)
  utils.buf_set_keymap(bufnr, "n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>", opts)
end

function M.common_on_init(client, _)
  if require("utilities.formatter").is_supported(vim.bo.filetype) then
    client.resolved_capabilities.document_formatting = false
  end
end

function M.common_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if not cmp_nvim_lsp_ok then
    return capabilities
  end

  return cmp_nvim_lsp.update_capabilities(capabilities)
end

function M.common_on_attach(_, bufnr)
  lsp_keybindings(bufnr)

  require("lsp_signature").on_attach {
    hint_enable = false,
    hi_parameter = "Underlined",
  }
end

function M.setup()
  local config = {
    virtual_text = {
      prefix = "",
      spacing = 0,
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  }

  vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "LspDiagnosticsSignError" })
  vim.fn.sign_define("DiagnosticSignWarning", { text = "", texthl = "LspDiagnosticsSignWarning" })
  vim.fn.sign_define("DiagnosticSignInformation", { text = "", texthl = "LspDiagnosticsSignInformation" })
  vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "LspDiagnosticsSignHint" })

  vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, _)
    local uri = result.uri
    local bufnr = vim.uri_to_bufnr(uri)
    if not bufnr then
      return
    end

    local vim_diag = require "vim.diagnostic"

    local diagnostics = result.diagnostics
    for i, diagnostic in ipairs(diagnostics) do
      local rng = diagnostic.range
      diagnostics[i].lnum = rng["start"].line
      diagnostics[i].end_lnum = rng["end"].line
      diagnostics[i].col = rng["start"].character
      diagnostics[i].end_col = rng["end"].character
    end

    local namespace = vim.lsp.diagnostic.get_namespace(ctx.client_id)
    vim_diag.set(namespace, bufnr, diagnostics, config)

    if not vim.api.nvim_buf_is_loaded(bufnr) then
      return
    end

    vim_diag.show(namespace, bufnr, diagnostics, config)
  end

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  --   border = "rounded",
  -- })

  vim.lsp.protocol.CompletionItemKind = {
    "   (Text) ",
    "   (Method)",
    "   (Function)",
    "   (Constructor)",
    " ﴲ  (Field)",
    "[] (Variable)",
    "   (Class)",
    " ﰮ  (Interface)",
    "   (Module)",
    " 襁 (Property)",
    "   (Unit)",
    "   (Value)",
    " 練 (Enum)",
    "   (Keyword)",
    "   (Snippet)",
    "   (Color)",
    "   (File)",
    "   (Reference)",
    "   (Folder)",
    "   (EnumMember)",
    " ﲀ  (Constant)",
    " ﳤ  (Struct)",
    "   (Event)",
    "   (Operator)",
    "   (TypeParameter)",
  }
end

return M

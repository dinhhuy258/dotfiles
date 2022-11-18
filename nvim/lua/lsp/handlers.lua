local utils = require "utils"
local M = {}

local function lsp_keybindings(bufnr)
  local opts = { noremap = true, silent = true }

  utils.buf_set_keymap(bufnr, "n", "gd", "<CMD>lua require('telescope.builtin').lsp_definitions()<CR>", opts)
  utils.buf_set_keymap(bufnr, "n", "gr", "<CMD>lua require('telescope.builtin').lsp_references()<CR>", opts)
  utils.buf_set_keymap(bufnr, "n", "gi", "<CMD>lua require('telescope.builtin').lsp_implementations()<CR>", opts)
  utils.buf_set_keymap(bufnr, "n", "gy", "<CMD>lua require('telescope.builtin').lsp_type_definitions()<CR>", opts)
  utils.buf_set_keymap(bufnr, "n", "<Leader>ca", "<CMD>lua vim.lsp.buf.code_action()<CR>", opts)

  utils.buf_set_keymap(
    bufnr,
    "n",
    "g[",
    "<CMD>lua vim.diagnostic.goto_prev({ float = { border = 'rounded' } })<CR>",
    opts
  )
  utils.buf_set_keymap(
    bufnr,
    "n",
    "g]",
    "<CMD>lua vim.diagnostic.goto_next({ float = { border = 'rounded' } })<CR>",
    opts
  )
  utils.buf_set_keymap(bufnr, "n", "gl", "<CMD>lua vim.diagnostic.open_float({ border = 'rounded' })<CR>", opts)

  if require("utilities.formatter").is_supported(vim.bo.filetype) then
    utils.buf_set_keymap(bufnr, "n", "<Leader>cf", "<CMD>lua require('utilities.formatter').format()<CR>", opts)
  else
    utils.buf_set_keymap(bufnr, "n", "<Leader>cf", "<CMD>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  utils.buf_set_keymap(bufnr, "n", "<Leader>cr", "<CMD>lua vim.lsp.buf.rename()<CR>", opts)
  utils.buf_set_keymap(bufnr, "n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>", opts)

  if vim.bo.filetype == "go" then
    utils.buf_set_keymap(
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

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })

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

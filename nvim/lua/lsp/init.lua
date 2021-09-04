local utils = require "utils"
local M = {}

lsp_clients = {}

local function check_lsp_client_active(name)
  local clients = vim.lsp.get_active_clients()
  for _, client in pairs(clients) do
    if client.name == name then
      return true
    end
  end
  return false
end

local function add_lsp_buffer_keybindings(bufnr)
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
  utils.buf_set_keymap(bufnr, "n", "<Leader>ca", "<CMD>lua require('fzf-lua').lsp_code_actions()<CR>", opts)

  utils.buf_set_keymap(bufnr, "n", "g[", "<CMD>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  utils.buf_set_keymap(bufnr, "n", "g]", "<CMD>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  utils.buf_set_keymap(
    bufnr,
    "n",
    "gl",
    "<CMD>lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false, border = 'single' })<CR>",
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

  return capabilities
end

function M.common_on_init(client, _)
  if require("utilities.formatter").is_supported(vim.bo.filetype) then
    client.resolved_capabilities.document_formatting = false
  end
end

function M.common_on_attach(_, bufnr)
  add_lsp_buffer_keybindings(bufnr)
  require("lsp_signature").on_attach {
    hint_enable = false,
    hi_parameter = "Underlined",
  }
end

function M.config()
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

  -- Sign define
  vim.fn.sign_define(
    "LspDiagnosticsSignError",
    { texthl = "LspDiagnosticsSignError", text = "", numhl = "LspDiagnosticsSignError" }
  )
  vim.fn.sign_define(
    "LspDiagnosticsSignWarning",
    { texthl = "LspDiagnosticsSignWarning", text = "", numhl = "LspDiagnosticsSignWarning" }
  )
  vim.fn.sign_define(
    "LspDiagnosticsSignHint",
    { texthl = "LspDiagnosticsSignHint", text = "", numhl = "LspDiagnosticsSignHint" }
  )
  vim.fn.sign_define(
    "LspDiagnosticsSignInformation",
    { texthl = "LspDiagnosticsSignInformation", text = "", numhl = "LspDiagnosticsSignInformation" }
  )

  require("lsp.handlers").setup()
  require("lsp.clients").setup(M.common_on_attach, M.common_capabilities(), M.common_on_init)
end

function M.setup(lang)
  local lsp = lsp_clients[lang].lsp
  if check_lsp_client_active(lsp.provider) then
    return
  end

  local lspconfig = require "lspconfig"
  lspconfig[lsp.provider].setup(lsp.setup)
end

return M

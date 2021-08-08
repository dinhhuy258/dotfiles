local utils = require "utils"
local M = {}

lsp_clients = {}

local function add_lsp_buffer_keybindings(bufnr)
  local opts = { noremap = true, silent = true }
  utils.buf_set_keymap(bufnr, "n", "<Leader>ca", "<CMD>lua vim.lsp.buf.code_action()<CR>", opts)
  utils.buf_set_keymap(bufnr, "n", "gd", "<CMD>lua require('lsp.lsp-actions').definitions()<CR>", opts)
  utils.buf_set_keymap(bufnr, "n", "gD", "<CMD>lua require('lsp.lsp-actions').declarations()<CR>", opts)
  utils.buf_set_keymap(bufnr, "n", "gr", "<CMD>lua require('lsp.lsp-actions').references()<CR>", opts)
  utils.buf_set_keymap(bufnr, "n", "gi", "<CMD>lua require('lsp.lsp-actions').implementations()<CR>", opts)
  utils.buf_set_keymap(bufnr, "n", "gy", "<CMD>lua require('lsp.lsp-actions').typedefs()<CR>", opts)

  utils.buf_set_keymap(
    bufnr,
    "n",
    "g[",
    "<CMD>lua vim.lsp.diagnostic.goto_prev()<CR>",
    opts
  )
  utils.buf_set_keymap(
    bufnr,
    "n",
    "g]",
    "<CMD>lua vim.lsp.diagnostic.goto_next()<CR>",
    opts
  )
  utils.buf_set_keymap(
    bufnr,
    "n",
    "gl",
    "<CMD>lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false, border = 'single' })<CR>",
    opts
  )

  utils.buf_set_keymap(bufnr, "n", "<Leader>co", "<CMD>lua require('fzf-lua').lsp_document_symbols()<CR>", opts)
  utils.buf_set_keymap(bufnr, "n", "<Leader>ca", "<CMD>lua vim.lsp.buf.code_action()<CR>", opts)
  utils.buf_set_keymap(bufnr, "n", "<Leader>cf", "<CMD>lua vim.lsp.buf.formatting()<CR>", opts)
  utils.buf_set_keymap(bufnr, "n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>", opts)
end

local function common_capabilities()
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

local function common_on_init(client, _)
  local formatters = lsp_clients.lang[vim.bo.filetype].formatters
  if not vim.tbl_isempty(formatters) and formatters[1]["exe"] ~= nil and formatters[1].exe ~= "" then
    client.resolved_capabilities.document_formatting = false
  end
end

local function common_on_attach(_, bufnr)
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

  require("lsp.lsp-handlers").setup()
  require("lsp.lsp-clients").setup(common_on_attach, common_capabilities(), common_on_init)
end

function M.setup(lang)
  local lsp = lsp_clients[lang].lsp
  if require("utils").check_lsp_client_active(lsp.provider) then
    return
  end

  local lspconfig = require "lspconfig"
  lspconfig[lsp.provider].setup(lsp.setup)
end

return M

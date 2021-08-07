local utils = require "utils"
local M = {}

lsp_clients = {}

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

local function common_on_attach(_, _)
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

  -- Lsp key mappings
  -- utils.set_keymap("n", "gd", "<CMD>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
  utils.set_keymap(
    "n",
    "gd",
    "<CMD>lua require('fzf-lua').lsp_definitions({ jump_to_single_result = true })<CR>",
    { noremap = true, silent = true }
  )
  utils.set_keymap("n", "gD", "<CMD>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
  -- utils.set_keymap("n", "gr", "<CMD>lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "gr", "<CMD>lua require('fzf-lua').lsp_references()<CR>", { noremap = true, silent = true })
  -- utils.set_keymap("n", "gi", "<CMD>lua vim.lsp.buf.implementation()<CR>", { noremap = true, silent = true })
  utils.set_keymap(
    "n",
    "gi",
    "<CMD>lua require('fzf-lua').lsp_implementations()<CR>",
    { noremap = true, silent = true }
  )
  utils.set_keymap(
    "n",
    "gl",
    "<CMD>lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false, border = 'single' })<CR>",
    { noremap = true, silent = true }
  )
  utils.set_keymap("n", "gs", "<CMD>lua vim.lsp.buf.signature_help()<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })
  utils.set_keymap(
    "n",
    "g[",
    "<CMD>lua vim.lsp.diagnostic.goto_prev({popup_opts = { border = 'single' }})<CR>",
    { noremap = true, silent = true }
  )
  utils.set_keymap(
    "n",
    "g]",
    "<CMD>lua vim.lsp.diagnostic.goto_next({popup_opts = { border = 'single' }})<CR>",
    { noremap = true, silent = true }
  )
  -- utils.set_keymap("n", "ca", "<CMD>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "ca", "<CMD>lua require('fzf-lua').lsp_code_actions()<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "cf", "<CMD>lua vim.lsp.buf.formatting()<CR>", { noremap = true, silent = false })
  utils.set_keymap(
    "n",
    "co",
    "<CMD>lua require('fzf-lua').lsp_document_symbols()<CR>",
    { noremap = true, silent = false }
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

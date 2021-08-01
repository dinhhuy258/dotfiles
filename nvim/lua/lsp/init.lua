local utils = require 'utils'
local M = {}

function M.config()
  vim.lsp.protocol.CompletionItemKind = nvim.lsp.completion.item_kind

  for _, sign in ipairs(nvim.lsp.diagnostics.signs.values) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  utils.set_keymap("n", "gd", "<CMD>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "gD", "<CMD>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "gr", "<CMD>lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "gi", "<CMD>lua vim.lsp.buf.implementation()<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "gl", "<CMD>lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false, border = 'single' })<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "gs", "<CMD>lua vim.lsp.buf.signature_help()<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "g[", "<CMD>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = nvim.lsp.popup_border}})<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "g]", "<CMD>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = nvim.lsp.popup_border}})<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "g]", "<CMD>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = nvim.lsp.popup_border}})<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "ga", "<CMD>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "gf", "<CMD>lua vim.lsp.buf.formatting()<CR>", { noremap = true, silent = false })

  require("lsp.handlers").setup()
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
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
  return capabilities
end

function M.common_on_init(client, bufnr)
  if nvim.lsp.on_init_callback then
    nvim.lsp.on_init_callback(client, bufnr)
    return
  end

  local formatters = nvim.lang[vim.bo.filetype].formatters
  if not vim.tbl_isempty(formatters) then
    client.resolved_capabilities.document_formatting = false
  end
end

function M.common_on_attach(client, bufnr)
  if nvim.lsp.on_attach_callback then
    nvim.lsp.on_attach_callback(client, bufnr)
  end
  lsp_highlight_document(client)
end

function M.setup(lang)
  local lsp = nvim.lang[lang].lsp
  if require("utils").check_lsp_client_active(lsp.provider) then
    return
  end

  local lspconfig = require "lspconfig"
  lspconfig[lsp.provider].setup(lsp.setup)
end

return M


local M = {}

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
    border = "single",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "single",
  })
end

return M

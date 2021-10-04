local M = {}

function M.setup()
  vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, _)
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

    local uri = result.uri
    local bufnr = vim.uri_to_bufnr(uri)
    if not bufnr then
      return
    end

    local diagnostics = result.diagnostics

    vim.lsp.diagnostic.save(diagnostics, bufnr, ctx.client_id)
    if not vim.api.nvim_buf_is_loaded(bufnr) then
      return
    end

    vim.lsp.diagnostic.display(diagnostics, bufnr, ctx.client_id, config)
  end

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "single",
  })
end

return M

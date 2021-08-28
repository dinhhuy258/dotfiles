local M = {}

function M.setup()
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      prefix = "",
      spacing = 0,
    },
    signs = true,
    underline = true,
  })

  vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, _, params, client_id, _)
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
    local uri = params.uri
    local bufnr = vim.uri_to_bufnr(uri)

    if not bufnr then
      return
    end

    local diagnostics = params.diagnostics

    for i, v in ipairs(diagnostics) do
      local source = v.source
      if source then
        if string.find(source, "/") then
          source = string.sub(v.source, string.find(v.source, "([%w-_]+)$"))
        end
        diagnostics[i].message = string.format("%s: %s", source, v.message)
      else
        diagnostics[i].message = string.format("%s", v.message)
      end

      if vim.tbl_contains(vim.tbl_keys(v), "code") then
        diagnostics[i].message = diagnostics[i].message .. string.format(" [%s]", v.code)
      end
    end

    vim.lsp.diagnostic.save(diagnostics, bufnr, client_id)

    if not vim.api.nvim_buf_is_loaded(bufnr) then
      return
    end

    vim.lsp.diagnostic.display(diagnostics, bufnr, client_id, config)
  end

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "single",
  })
end

return M

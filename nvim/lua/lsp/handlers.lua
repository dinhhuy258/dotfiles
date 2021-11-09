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

  if vim.fn.has "nvim-0.5.1" > 0 then
    vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, _)
      local uri = result.uri
      local bufnr = vim.uri_to_bufnr(uri)
      if not bufnr then
        return
      end

      local diagnostics = result.diagnostics
      local ok, vim_diag = pcall(require, "vim.diagnostic")
      if ok then
        -- FIX: why can't we just use vim.diagnostic.get(buf_id)?
        config.signs = true
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

        local sign_names = {
          "DiagnosticSignError",
          "DiagnosticSignWarn",
          "DiagnosticSignInfo",
          "DiagnosticSignHint",
        }
        local sign_values = {
          { name = "LspDiagnosticsSignError", text = "" },
          { name = "LspDiagnosticsSignWarning", text = "" },
          { name = "LspDiagnosticsSignHint", text = "" },
          { name = "LspDiagnosticsSignInformation", text = "" },
        }
        for i, sign in ipairs(sign_values) do
          vim.fn.sign_define(sign_names[i], { texthl = sign_names[i], text = sign.text, numhl = "" })
        end
        vim_diag.show(namespace, bufnr, diagnostics, config)
      else
        vim.lsp.diagnostic.save(diagnostics, bufnr, ctx.client_id)
        if not vim.api.nvim_buf_is_loaded(bufnr) then
          return
        end
        vim.lsp.diagnostic.display(diagnostics, bufnr, ctx.client_id, config)
      end
    end
  else
    vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, _)
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
  end

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "single",
  })
end

return M

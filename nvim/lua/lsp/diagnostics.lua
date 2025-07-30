-- Modern LSP diagnostics configuration
local M = {}

function M.setup()
  -- Enhanced diagnostic configuration
  vim.diagnostic.config({
    virtual_text = {
      severity = { min = vim.diagnostic.severity.WARN },
      source = "if_many",
      format = function(diagnostic)
        local icons = {
          [vim.diagnostic.severity.ERROR] = "󰅚",
          [vim.diagnostic.severity.WARN] = "󰀪",
          [vim.diagnostic.severity.INFO] = "󰌶",
          [vim.diagnostic.severity.HINT] = "󰛩",
        }
        local icon = icons[diagnostic.severity] or "●"
        return string.format("%s %s", icon, diagnostic.message)
      end,
    },
    
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "󰅚",
        [vim.diagnostic.severity.WARN] = "󰀪", 
        [vim.diagnostic.severity.INFO] = "󰌶",
        [vim.diagnostic.severity.HINT] = "󰛩",
      },
      numhl = {
        [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
        [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
        [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
        [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      },
    },
    
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "Diagnostics:",
      prefix = function(diagnostic, i, total)
        local level = vim.diagnostic.severity[diagnostic.severity]
        local prefix = string.format("%d. %s ", i, level:sub(1, 1):upper() .. level:sub(2):lower())
        return prefix, "Diagnostic" .. level:gsub("^%l", string.upper)
      end,
    },
  })

  -- LSP handlers with modern styling
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
    title = "Hover",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
    title = "Signature Help", 
  })
end

return M
local keymaps = require "config.keymaps"

local M = {}

M.setup = function()
  local conform_ok, conform = pcall(require, "conform")
  if not conform_ok then
    return
  end

  conform.setup {
    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      graphql = { "prettier" },
      lua = { "stylua" },
      python = { "isort", "black" },
      cpp = { "clang_format" },
      php = { "pint" },
      sh = { "shfmt" },
    },
  }

  conform.formatters.shfmt = {
    prepend_args = { "-i", "2" },
  }

  keymaps.set({ "n", "v" }, "<Leader>cf", function()
    conform.format {
      lsp_fallback = true,
      async = false,
      timeout_ms = 1000,
    }
  end)
end

return M

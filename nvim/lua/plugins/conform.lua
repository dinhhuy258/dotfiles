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
      hcl = { "terragrunt_hclfmt" },
      tf = { "terraform_fmt" },
    },
  }

  conform.formatters.shfmt = {
    prepend_args = { "-i", "2" },
  }

  keymaps.set({ "n", "v" }, "<Leader>cf", function()
    conform.format {
      lsp_fallback = true,
      async = false,
      timeout_ms = 5000,
    }
    vim.notify("Format complete", vim.log.levels.INFO)
  end)
end

return M

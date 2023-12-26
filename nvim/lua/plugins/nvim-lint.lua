local M = {}

M.setup = function()
  local lint_ok, lint = pcall(require, "lint")
  if not lint_ok then
    return
  end

  lint.linters_by_ft = {
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    typescriptreact = { "eslint_d" },
    python = { "pylint" },
    go = { "golangcilint" },
    ruby = { "rubocop" },
  }

  local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    group = lint_augroup,
    callback = function()
      require("lint").try_lint()
    end,
  })
end

return M

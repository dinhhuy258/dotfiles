local M = {}

function M.config(common_on_attach, common_capabilities, common_on_init)
  lsp_clients['cpp'] = {
    formatters = {
      {
        -- @usage can be clang-format or uncrustify
        exe = "clang-format",
        args = {},
        stdin = true,
      },
    },
    linters = {},
    lsp = {
      provider = "clangd",
      setup = {
        cmd = {
          -- vim.fn.stdpath "data" .. "/lspinstall/cpp/clangd/bin/clangd",
          "clangd",
          "--background-index",
          "--header-insertion=never",
          "--cross-file-rename",
          "--clang-tidy",
          "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*",
        },
        filetypes = { "cpp" },
        on_attach = common_on_attach,
        on_init = common_on_init,
        capabilities = common_capabilities,
      },
    },
  }
end

return M


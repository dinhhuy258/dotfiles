local M = {}

function M.config(common_on_attach, common_capabilities, common_on_init)
  lsp_clients["go"] = {
    formatters = {
      {
        -- @usage can be gofmt or goimports or gofumpt
        exe = "gofmt",
        args = {},
        stdin = true,
      },
    },
    lsp = {
      provider = "gopls",
      setup = {
        cmd = {
          vim.fn.stdpath "data" .. "/lspinstall/go/gopls",
        },
        on_attach = common_on_attach,
        on_init = common_on_init,
        capabilities = common_capabilities,
      },
    },
  }
end

return M

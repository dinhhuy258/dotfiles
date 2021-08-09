local M = {}

function M.config(common_on_attach, common_capabilities, common_on_init)
  lsp_clients["python"] = {
    formatters = {
      {
        -- @usage can be black or yapf or isort
        exe = "",
        args = {},
      },
    },
    linters = {},
    lsp = {
      provider = "pyright",
      setup = {
        cmd = {
          vim.fn.stdpath "data" .. "/lspinstall/python/node_modules/.bin/pyright-langserver",
          "--stdio",
        },
        on_attach = common_on_attach,
        on_init = common_on_init,
        capabilities = common_capabilities,
      },
    },
  }
end

return M

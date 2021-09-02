local M = {}

function M.config(common_on_attach, common_capabilities, common_on_init)
  lsp_clients["javascript"] = {
    lsp = {
      provider = "tsserver",
      setup = {
        cmd = {
          vim.fn.stdpath "data" .. "/lspinstall/typescript/node_modules/.bin/typescript-language-server",
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

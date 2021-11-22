local M = {}

function M.config(common_on_attach, common_capabilities, common_on_init)
  lsp_clients["typescript"] = {
    lsp = {
      provider = "tsserver",
      setup = {
        on_attach = common_on_attach,
        on_init = common_on_init,
        capabilities = common_capabilities,
      },
    },
  }
end

return M

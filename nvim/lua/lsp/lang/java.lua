local M = {}

function M.config(common_on_attach, common_capabilities, common_on_init)
  lsp_clients["java"] = {
    lsp = {
      provider = "jdtls",
      setup = {
        capabilities = common_capabilities,
        on_attach = common_on_attach,
        on_init = common_on_init,
        autostart = false,
      },
    },
  }
end

return M

local M = {}

function M.config(common_on_attach, _, common_on_init)
  lsp_clients["php"] = {
    lsp = {
      provider = "intelephense",
      setup = {
        on_attach = common_on_attach,
        on_init = common_on_init,
        settings = {
          intelephense = {
            environment = {
              phpVersion = "7.4",
            },
          },
        },
      },
    },
  }
end

return M

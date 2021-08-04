local M = {}

function M.config(common_on_attach, _, common_on_init)
  lsp_clients["php"] = {
    formatters = {
      {
        -- @usage can be phpcbf
        exe = "",
        args = {},
      },
    },
    lsp = {
      provider = "intelephense",
      setup = {
        cmd = {
          vim.fn.stdpath "data" .. "/lspinstall/php/node_modules/.bin/intelephense",
          "--stdio",
        },
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

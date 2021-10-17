local M = {}

function M.config(common_on_attach, common_capabilities, common_on_init)
  lsp_clients["json"] = {
    lsp = {
      provider = "jsonls",
      setup = {
        on_attach = common_on_attach,
        on_init = common_on_init,
        capabilities = common_capabilities,
        commands = {
          Format = {
            function()
              vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
            end,
          },
        },
      },
    },
  }
end

return M

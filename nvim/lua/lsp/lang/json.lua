local M = {}

function M.config(common_on_attach, common_capabilities, common_on_init)
  local schemas = nil
  local status_ok, jsonls_settings = pcall(require, "nlspsettings.jsonls")
  if status_ok then
    schemas = jsonls_settings.get_default_schemas()
  end

  lsp_clients['json'] = {
        formatters = {
      {
        -- @usage can be json_tool or prettier or prettierd
        exe = "",
        args = {},
        stdin = true,
      },
    },
    lsp = {
      provider = "jsonls",
      setup = {
        cmd = {
          "node",
          vim.fn.stdpath "data" .. "/lspinstall/json/vscode-json/json-language-features/server/dist/node/jsonServerMain.js",
          "--stdio",
        },
        filetypes = { "json" },
        on_attach = common_on_attach,
        on_init = common_on_init,
        capabilities = common_capabilities,
        settings = {
          json = {
            schemas = schemas,
            --   = {
            --   {
            --     fileMatch = { "package.json" },
            --     url = "https://json.schemastore.org/package.json",
            --   },
            -- },
          },
        },
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

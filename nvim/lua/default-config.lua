nvim = {
  lsp = {
    on_attach_callback = nil,
    on_init_callback = nil,
  },
}

local schemas = nil
local lsp = require "lsp"
local common_on_attach = lsp.common_on_attach
local common_capabilities = lsp.common_capabilities()
local common_on_init = lsp.common_on_init
local status_ok, jsonls_settings = pcall(require, "nlspsettings.jsonls")
if status_ok then
  schemas = jsonls_settings.get_default_schemas()
end

nvim.lang = {
  go = {
    formatters = {
      {
        -- @usage can be gofmt or goimports or gofumpt
        exe = "gofmt",
        args = {},
        stdin = true,
      },
    },
    linters = {},
    lsp = {
      provider = "gopls",
      setup = {
        cmd = {
          DATA_PATH .. "/lspinstall/go/gopls",
        },
        on_attach = common_on_attach,
        on_init = common_on_init,
        capabilities = common_capabilities,
      },
    },
  },
  json = {
    formatters = {
      {
        -- @usage can be json_tool or prettier or prettierd
        exe = "",
        args = {},
        stdin = true,
      },
    },
    linters = {},
    lsp = {
      provider = "jsonls",
      setup = {
        cmd = {
          "node",
          DATA_PATH .. "/lspinstall/json/vscode-json/json-language-features/server/dist/node/jsonServerMain.js",
          "--stdio",
        },
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
  },
}


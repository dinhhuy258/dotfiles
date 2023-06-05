local handlers = require "lsp.handlers"

local M = {}

function M.setup()
  local servers = {
    "clangd", -- c, c++
    "tsserver", -- typescript, javascript
    "jsonls", -- json
    "lua_ls", -- lua
    "intelephense", -- php
    "pyright", -- python
    "sqlls", -- sql
    "yamlls", -- yaml
    "gopls", -- go
  }

  local settings = {
    ui = {
      border = "none",
      icons = {
        package_installed = "◍",
        package_pending = "◍",
        package_uninstalled = "◍",
      },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
  }

  require("mason").setup(settings)
  require("mason-lspconfig").setup {
    ensure_installed = servers,
    automatic_installation = true,
  }

  local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
  if not lspconfig_status_ok then
    return
  end

  local opts = {}

  for _, server in pairs(servers) do
    opts = {
      on_init = handlers.common_on_init,
      on_attach = handlers.common_on_attach,
      capabilities = handlers.common_capabilities(),
    }

    server = vim.split(server, "@")[1]

    local require_ok, conf_opts = pcall(require, "lsp.settings." .. server)
    if require_ok then
      opts = vim.tbl_deep_extend("force", conf_opts, opts)
    end

    lspconfig[server].setup(opts)
  end
end

return M

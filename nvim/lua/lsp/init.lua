local handlers = require "lsp.handlers"
local M = {}

function M.setup()
  local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
  if not lspconfig_ok then
    return
  end

  local lsp_installer_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
  if not lsp_installer_ok then
    return
  end

  local servers = {
    "clangd", -- c, c++
    "tsserver", -- typescript, javascript
    "jsonls", -- json
    "sumneko_lua", -- lua
    "intelephense", -- php
    "pyright", -- python
    "sqls", -- sql
    "yamlls", -- yaml
    "gopls", -- go
  }
  lsp_installer.setup {
    ensure_installed = servers,
  }

  for _, server in pairs(servers) do
    local opts = {
      on_init = handlers.common_on_init,
      capabilities = handlers.common_capabilities(),
      on_attach = handlers.common_on_attach,
    }

    local has_custom_opts, server_custom_opts = pcall(require, "lsp.settings." .. server)
    if has_custom_opts then
      opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
    end

    lspconfig[server].setup(opts)
  end

  handlers.setup()
end

return M

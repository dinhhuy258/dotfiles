local handlers = require "lsp.handlers"
local servers = require "lsp.servers"

local M = {}

function M.setup()
  handlers.setup()

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

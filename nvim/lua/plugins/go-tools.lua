local M = {}

function M.setup()
  local go_lsp_ok, go_lsp = pcall(require, "go-tools.lsp")
  local go_ok, go = pcall(require, "go-tools")
  if not go_lsp_ok or not go_ok then
    return
  end

  local lsp = require "lsp"

  go.setup()
  go_lsp.setup(lsp.common_on_attach, lsp.common_capabilities(), lsp.common_on_init)
end

return M

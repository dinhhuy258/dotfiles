local M = {}

function M.setup()
  local status_ok, vintellij = pcall(require, "vintellij")
  if not status_ok then
    return
  end

  local lsp = require "lsp"

  vintellij.setup(lsp.common_on_attach, lsp.common_capabilities(), lsp.common_on_init)
end

return M

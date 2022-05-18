local M = {}

function M.setup()
  local status_ok, vintellij = pcall(require, "vintellij")
  if not status_ok then
    return
  end

  local handlers = require "lsp.handlers"

  local lib_dirs = {
    "/Users/dinhhuy258/.gradle/",
    "/Library/Java/JavaVirtualMachines",
  }

  vintellij.setup {
    debug = true,
    common_on_attach = handlers.common_on_attach,
    common_capabilities = handlers.common_capabilities(),
    common_on_init = handlers.common_on_init,
    lib_dirs = lib_dirs,
  }
end

return M

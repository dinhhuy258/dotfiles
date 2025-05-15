local icons = require "icons"

local M = {}

function M.setup()
  local mason_ok, mason = pcall(require, "mason")
  if not mason_ok then
    return
  end

  mason.setup {
    ui = {
      border = "rounded",
      icons = {
        package_installed = icons.mason.package_installed,
        package_pending = icons.mason.package_pending,
        package_uninstalled = icons.mason.package_uninstalled,
      },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
  }
end

return M

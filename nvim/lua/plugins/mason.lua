local servers = require "lsp.servers"
local icons = require "icons"

local M = {}

function M.setup()
  local mason_ok, mason = pcall(require, "mason")
  if not mason_ok then
    return
  end

  local mason_lsp_config_ok, mason_lsp_config = pcall(require, "mason-lspconfig")
  if not mason_lsp_config_ok then
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

  mason_lsp_config.setup {
    ensure_installed = servers,
    automatic_installation = true,
  }

  local mason_tool_installer_ok, mason_tool_installer = pcall(require, "mason-tool-installer")
  if not mason_tool_installer_ok then
    return
  end

  mason_tool_installer.setup {
    ensure_installed = {
      "prettier",
      "stylua",
      "isort", -- python
      "black", -- python
      "clang-format",
      -- "pint", -- php
      "golangci-lint",
      "pylint",
      "eslint_d",
      -- "rubocop", -- ruby
      -- "jdtls",
      "shfmt",
      "shellcheck",
      -- Debuggers
      -- "php-debug-adapter",
    },
  }
end

return M

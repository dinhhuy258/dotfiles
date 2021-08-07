-- Disable builtin vim plugins
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit",
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

-- Load plugins
local packer = require("plugins.packer").init()
local plugins = require "plugins.plugins"
packer:load { plugins }

-- Load lsp config
require("lsp").config()

require("general.autocmds").define_default_autogroups()

require "general.settings"
require "general.mappings"

require "themes.lightline"

vim.cmd "colorscheme iceberg"

-- Disable builtin vim plugins
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  -- "zip", (vintellij)
  -- "zipPlugin", (vintellij)
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

-- Config variable for my plugins
vim.g.huy_duong_workspace = 1

-- Load plugins
local packer = require("plugins.packer").init()
local plugins = require "plugins.plugins"
packer:load { plugins }

-- Load lsp config
require("lsp").setup()

require("general.autocmds").define_default_autogroups()

require("general.options").setup()
require("general.mappings").setup()
require("general.commands").setup()

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

-- config variable for my plugins
vim.g.huy_duong_workspace = 1

-- change leader key to semicolon
vim.g.mapleader = ";" -- make sure to set `mapleader` before lazy

require "utils.table"

-- load plugins
require("plugins.lazy").init()

-- load lsp config
require("lsp").setup()

require("autocmds").define_default_autogroups()
require("options").setup()
require("colorschema").setup()
require("keymappings").setup()
require("commands").setup()

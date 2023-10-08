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

-- load plugins
require("plugin_loader").init()

-- load lsp config
require("lsp").setup()

-- load config
require("config.autocmds").setup()
require("config.options").setup()
require("config.colorschema").setup()
require("config.keymaps").setup()
require("config.commands").setup()

-- load core
require("core.tasks").setup()
require("core.open").setup()
require("core.nohlsearch").setup()
require("core.statusline").setup()
require("core.cutlass").setup()

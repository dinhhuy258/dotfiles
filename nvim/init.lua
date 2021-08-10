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

require "general.options".setup()
require "general.mappings"

-- Abbreviations
vim.cmd "cnoreabbrev W! w!"
vim.cmd "cnoreabbrev Q! q!"
vim.cmd "cnoreabbrev Qall! qall!"
vim.cmd "cnoreabbrev Wq wq"
vim.cmd "cnoreabbrev Wa wa"
vim.cmd "cnoreabbrev wQ wq"
vim.cmd "cnoreabbrev WQ wq"
vim.cmd "cnoreabbrev W w"
vim.cmd "cnoreabbrev Q q"
vim.cmd "cnoreabbrev Qall qall"

vim.cmd "colorscheme iceberg"

-- Config variable for my plugins
vim.g.huy_duong_workspace = 1


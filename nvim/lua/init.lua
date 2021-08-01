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
    "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

-- Load plugins
local packer = require("plugins.packer").init()
local plugins = require "plugins.plugins"
packer:load { plugins }

-- Load lsp default configs
require "lsp.default-config"
-- Load lsp config
require("lsp.lsp-config").config()

require("general.autocmds").define_default_autogroups()

require 'general.settings'
require 'general.mappings'

require 'themes.colorscheme'
require 'themes.lightline'

require 'plugins.vim-easymotion'
require 'plugins.vim-startify'
require 'plugins.vim-gitgutter'
require 'plugins.vim-submode'
require 'plugins.vim-fugitive'
require 'plugins.lightline-bufferline'
require 'plugins.fzf'
require 'plugins.clever-f'
-- require 'plugins.coc'
require 'plugins.nvim-treesitter'

-- TODO: Load in ftplugin
require("lsp.lsp-config").setup "go"
require("lsp.lsp-config").setup "lua"
require("lsp.lsp-config").setup "json"

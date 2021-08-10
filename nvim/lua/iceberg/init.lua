vim.api.nvim_command "hi clear"
if vim.fn.exists "syntax_on" then
  vim.api.nvim_command "syntax reset"
end

vim.g.colors_name = "iceberg"

local utils = require "iceberg.utils"

local async
async = vim.loop.new_async(vim.schedule_wrap(function()
  local skeletons = {}
  for _, skeleton in ipairs(skeletons) do
    utils.initialise(skeleton)
  end

  async:close()
end))

local highlights = require "iceberg.highlights"
local lsp = require "iceberg.lsp"
local startify = require "iceberg.vim-startify"
local gitsigns = require "iceberg.gitsigns"
local tree = require "iceberg.nvim-tree"
local barbar = require "iceberg.barbar"
local easymotion = require "iceberg.vim-easymotion"

local skeletons = {
  highlights,
  lsp,
  startify,
  gitsigns,
  tree,
  barbar,
  easymotion,
}

for _, skeleton in ipairs(skeletons) do
  utils.initialise(skeleton)
end

async:send()

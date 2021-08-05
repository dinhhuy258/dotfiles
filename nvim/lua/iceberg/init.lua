vim.api.nvim_command "hi clear"
if vim.fn.exists "syntax_on" then
  vim.api.nvim_command "syntax reset"
end

vim.o.background = "dark"
vim.o.termguicolors = true
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

local skeletons = {
  highlights,
}

for _, skeleton in ipairs(skeletons) do
  utils.initialise(skeleton)
end

async:send()

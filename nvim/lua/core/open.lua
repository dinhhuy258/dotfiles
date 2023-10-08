local keymaps = require "config.keymaps"

local M = {}

local function open_file(path)
  local dir = ""
  if vim.fn.isdirectory(path) then
    dir = path
  else
    dir = vim.fn.fnamemodify(path, ":h")
  end

  if not vim.fn.isdirectory(dir) then
    -- if the directory was moved/deleted
    return
  end

  if vim.fn.filereadable(path) then
    vim.fn.system("open --reveal " .. vim.fn.shellescape(path))
  else
    vim.fn.system("open " .. vim.fn.shellescape(dir))
  end
end

function M.setup()
  keymaps.set("n", "gof", function()
    open_file(vim.fn.expand "%:p")
  end)

  keymaps.set("n", "goF", function()
    open_file(vim.fn.getcwd())
  end)
end

return M

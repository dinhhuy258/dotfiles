local keymappings = require "keymappings"

local M = {}

M.setup = function()
  local status_ok, neotest = pcall(require, "neotest")
  if not status_ok then
    return
  end

  neotest.setup {
    adapters = {
      require "neotest-phpunit",
      require "neotest-go",
    },
  }

  -- setup keymap
  keymappings.set("n", "<Leader>tr", ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>', { noremap = true })
  keymappings.set("n", "<Leader>tn", ':lua require("neotest").run.run()<CR>', { noremap = true })
  keymappings.set("n", "<Leader>to", ':lua require("neotest").output.open({ enter = true })<CR>', { noremap = true })
end

return M

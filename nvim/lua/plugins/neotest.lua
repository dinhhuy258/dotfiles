local keymaps = require "config.keymaps"

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
      require("neotest-rspec")
    },
  }

  require "neotest-phpunit" {
    phpunit_cmd = function()
      return "vendor/bin/phpunit"
    end,
  }

  -- setup keymap
  -- run nearest test
  keymaps.set("n", "<Leader>tt", ':lua require("neotest").run.run()<CR>', { noremap = true })
  -- run the current file
  keymaps.set("n", "<Leader>tT", ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>', { noremap = true })
  -- run the last test
  keymaps.set("n", "<Leader>t.", ':lua require("neotest").run.run_last()<CR>', { noremap = true })
  -- quit the test
  keymaps.set("n", "<Leader>tq", ':lua require("neotest").run.stop()<CR>', { noremap = true })
  -- open output window
  keymaps.set("n", "<Leader>to", ':lua require("neotest").output.open({ enter = true })<CR>', { noremap = true })
  -- open output summary
  keymaps.set("n", "<Leader>ts", ':lua require("neotest").summary.toggle()<CR>', { noremap = true })

  local group = vim.api.nvim_create_augroup("dotfiles_neotest_close_with_q", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = {
      "neotest-output",
      "neotest-summary",
    },
    callback = function(event)
      vim.bo[event.buf].buflisted = false
      vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
  })
end

return M

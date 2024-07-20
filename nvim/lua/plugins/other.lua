local keymaps = require "config.keymaps"

local M = {}

function M.setup()
  local other_ok, other = pcall(require, "other-nvim")
  if not other_ok then
    return
  end

  keymaps.set("n", "<Leader>aa", "<cmd>:Other<CR>", { noremap = true, silent = true })

  other.setup {
    mappings = {
      "golang",
      -- python
      {
        context = "test",
        pattern = "(.*)/src/(.*).py$",
        target = "%1/test/test_%2.py",
      },
      {
        context = "implementation",
        pattern = "(.*)/test/test_(.*).py$",
        target = "%1/src/%2.py",
      },
      -- laravel
      {
        context = "controller test",
        pattern = "/app/Http/Controllers/.*/(.*)Controller.php$",
        target = "/tests/Feature/%1ControllerTest.php",
      },
      {
        context = "controller implementation",
        pattern = "/tests/Feature/(.*)ControllerTest.php$",
        target = "/app/Http/Controllers/*/%1Controller.php",
      },
    },
  }
end

return M

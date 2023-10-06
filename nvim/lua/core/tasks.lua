local keymaps = require "config.keymaps"

local M = {}

function M.setup()
  keymaps.set("n", "<leader>rr", function()
    require("core.float_input").input(function(input)
      vim.cmd("VimuxRunCommand " .. '"' .. input .. '"')
    end, {
      prompt = "Command:",
    })
  end)

  keymaps.set("n", "<leader>r.", ":VimuxRunLastCommand<CR>")
end

return M

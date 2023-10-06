local keymaps = require "config.keymaps"

local M = {}

function M.setup()
  local go_ok, go = pcall(require, "go")
  if not go_ok then
    return
  end

  keymaps.set("n", "<Leader>dq", "<CMD>GoDebugStop<CR>", { noremap = false })

  go.setup {
    dap = {
      configurations = {
        {
          type = "go",
          name = "Start server",
          request = "launch",
          showLog = false,
          program = "main.go",
          args = { "server" },
        },
      },
    },
  }
end

return M

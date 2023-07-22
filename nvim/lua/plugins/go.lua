local keymap = require "utils.keymap"

local M = {}

function M.setup()
  local go_ok, go = pcall(require, "go")
  if not go_ok then
    return
  end

  keymap.set("n", "<Leader>dq", "<CMD>GoDebugStop<CR>", { noremap = false })

  go.setup()
end

return M

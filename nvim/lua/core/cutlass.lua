local keymaps = require "config.keymaps"

local M = {}

function M.setup()
  local bindings = {
    { "c", '"_c', "nx" },
    { "cc", '"_S', "n" },
    { "C", '"_C', "nx" },
    { "s", '"_s', "nx" },
    { "S", '"_S', "nx" },
    { "d", '"_d', "nx" },
    { "dd", '"_dd', "n" },
    { "D", '"_D', "nx" },
    { "x", '"_x', "n" },
    { "X", '"_X', "nx" },
  }

  for _, binding in pairs(bindings) do
    binding[3]:gsub(".", function(mode)
      keymaps.set(mode, binding[1], binding[2], {
        noremap = true,
        silent = true,
      })
    end)
  end
end

return M

local keymaps = require "config.keymaps"
local icons = require "icons"

local M = {}

M.setup = function()
  local ufo_status_ok, ufo = pcall(require, "ufo")
  if not ufo_status_ok then
    return
  end

  local statuscol_status_ok, statuscol = pcall(require, "statuscol")
  if not statuscol_status_ok then
    return
  end

  local statuscol_builtin_status_ok, statuscol_builtin = pcall(require, "statuscol.builtin")
  if not statuscol_builtin_status_ok then
    return
  end

  statuscol.setup {
    relculright = true,
    segments = {
      { text = { statuscol_builtin.foldfunc }, click = "v:lua.ScFa" },
      { text = { "%s" }, click = "v:lua.ScSa" },
      { text = { statuscol_builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
    },
  }

  keymaps.set("n", "zR", ufo.openAllFolds)
  keymaps.set("n", "zM", ufo.closeAllFolds)

  ufo.setup {
    provider_selector = function()
      return { "treesitter", "indent" }
    end,
  }
end

return M

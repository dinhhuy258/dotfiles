local keymaps = require "config.keymaps"

local M = {}

M.setup = function()
  local harpoon_ok, harpoon = pcall(require, "harpoon")
  if not harpoon_ok then
    return
  end

  harpoon.setup {}

  local harpoon_mark = require("harpoon.mark")
  local harpoon_ui = require("harpoon.ui")

  keymaps.set("n", "<Leader>ma", function()
    harpoon_mark.add_file()
  end, { noremap = true, silent = true })

  keymaps.set("n", "<Leader>mn", function()
    harpoon_ui.nav_next()
  end, { noremap = true, silent = true })

  keymaps.set("n", "<Leader>mN", function()
    harpoon_ui.nav_prev()
  end, { noremap = true, silent = true })

  keymaps.set("n", "<Leader>mm", function()
    harpoon_ui.toggle_quick_menu()
  end, { noremap = true, silent = true })

  keymaps.set("n", "<Leader>mt", "<CMD>Telescope harpoon marks<CR>", { noremap = true, silent = true })
end

return M

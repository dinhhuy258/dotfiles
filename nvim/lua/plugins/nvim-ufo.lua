local keymaps = require "config.keymaps"
local icons = require "icons"

local M = {}

local function handler(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (" %s %d "):format(icons.nvim_ufo.fold_suffix, endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0

  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)

    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end

    curWidth = curWidth + chunkWidth
  end

  table.insert(newVirtText, { suffix, "MoreMsg" })

  return newVirtText
end

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
    fold_virt_text_handler = handler,
  }
end

return M

local M = {}

function M.setup()
  local status_ok, tokyonight = pcall(require, "tokyonight")
  if not status_ok then
    return
  end

  tokyonight.setup {
    style = "night",
    transparent = false,
    on_highlights = function(highlights, colors)
      highlights.CursorLine.bg = colors.none
      highlights.StatusLine.bg = colors.none
      highlights.StatusLineNC.bg = colors.none

      -- tree sitter context
      highlights.TreesitterContext.bg = colors.none

      -- barbar
      highlights.BufferCurrent.bg = colors.none
      highlights.BufferCurrentIndex.bg = colors.none
      highlights.BufferCurrentMod.bg = colors.none
      highlights.BufferCurrentSign.bg = colors.none
      highlights.BufferCurrentTarget.bg = colors.none

      highlights.BufferInactive.bg = colors.none
      highlights.BufferInactiveIndex.bg = colors.none
      highlights.BufferInactiveMod.bg = colors.none
      highlights.BufferInactiveSign.bg = colors.none
      highlights.BufferInactiveTarget.bg = colors.none

      highlights.BufferTabpageFill.bg = colors.bg
    end,
  }

  vim.cmd [[colorscheme tokyonight]]
end

return M

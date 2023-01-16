local M = {}

local function highlight(group, properties)
  local bg = properties.bg == nil and "" or "guibg=" .. properties.bg
  local fg = properties.fg == nil and "" or "guifg=" .. properties.fg
  local style = properties.style == nil and "" or "gui=" .. properties.style

  local cmd = table.concat({
    "highlight",
    group,
    bg,
    fg,
    style,
  }, " ")

  vim.api.nvim_command(cmd)
end

local function basicHighlights()
  highlight("CursorLine", { bg = "NONE" })
  highlight("StatusLine", { bg = "NONE" })
  highlight("StatusLineNC", { bg = "NONE" })
end

local function barbarHighlights()
  highlight("BufferCurrent", { bg = "NONE" })
  highlight("BufferCurrentIndex", { bg = "NONE" })
  highlight("BufferCurrentMod", { bg = "NONE" })
  highlight("BufferCurrentSign", { bg = "NONE" })
  highlight("BufferCurrentTarget", { bg = "NONE" })

  highlight("BufferInactive", { bg = "NONE" })
  highlight("BufferInactiveIndex", { bg = "NONE" })
  highlight("BufferInactiveMod", { bg = "NONE" })
  highlight("BufferInactiveSign", { bg = "NONE" })
  highlight("BufferInactiveTarget", { bg = "NONE" })

  highlight("BufferTabpageFill", { bg = "#1a1b26" })
end

function M.setup()
  local status_ok, tokyonight = pcall(require, "tokyonight")
  if not status_ok then
    return
  end

  tokyonight.setup {
    style = "night",
    transparent = false,
  }

  vim.cmd [[colorscheme tokyonight]]

  basicHighlights()
  barbarHighlights()
end

return M

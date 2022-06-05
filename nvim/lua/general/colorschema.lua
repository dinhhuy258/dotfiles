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

local function bufferLineHighlights()
  highlight("BufferLineFill", { bg = "NONE" })
end

function M.setup()
  vim.g.tokyonight_style = "night"
  vim.g.tokyonight_transparent = true
  vim.cmd [[colorscheme tokyonight]]

  basicHighlights()
  bufferLineHighlights()
end

return M

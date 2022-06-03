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

local function barbarColorschema()
  highlight("BufferCurrent", { bg = "NONE" })
  highlight("BufferCurrentIndex", { bg = "NONE" })
  highlight("BufferCurrentSign", { bg = "NONE" })
  highlight("BufferCurrentMod", { bg = "NONE" })
  highlight("BufferTabpageFill", { fg = "#c0caf5", bg = "NONE" })
end

local function basicColorschema()
  highlight("CursorLine", { bg = "NONE" })
end

function M.setup()
  vim.g.tokyonight_style = "night"
  vim.g.tokyonight_transparent = true
  vim.cmd [[colorscheme tokyonight]]

  basicColorschema()
  barbarColorschema()
end

return M

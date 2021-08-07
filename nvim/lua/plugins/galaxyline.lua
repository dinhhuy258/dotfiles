local M = {}

local colors = {
  bg = "#161821",
  fg = "#c6c8d1",
}

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand "%:t") ~= 1 then
    return true
  end
  return false
end

M.setup = function()
  local galaxyline = require "galaxyline"
  local galaxyline_section = galaxyline.section
  local galaxyline_condition = require "galaxyline.condition"
  galaxyline.short_line_list = { "NvimTree", "vista", "dbui" }

  table.insert(galaxyline_section.left, {
    Space = {
      provider = function()
        return " "
      end,
    },
  })

  table.insert(galaxyline_section.left, {
    FileIcon = {
      provider = "FileIcon",
      condition = buffer_not_empty,
      highlight = { require("galaxyline.provider_fileinfo").get_file_icon_color, colors.bg },
    },
  })

  table.insert(galaxyline_section.left, {
    FileName = {
      provider = function()
        return vim.fn.expand "%f"
      end,
      condition = buffer_not_empty,
      highlight = { colors.fg, colors.bg },
    },
  })

  table.insert(galaxyline_section.right, {
    GitIcon = {
      provider = function()
        return "  "
      end,
      condition = galaxyline_condition.check_git_workspace,
      highlight = { colors.fg, colors.bg },
    },
  })

  table.insert(galaxyline_section.right, {
    GitBranch = {
      provider = "GitBranch",
      condition = galaxyline_condition.check_git_workspace,
      highlight = { colors.fg, colors.bg },
    },
  })

  table.insert(galaxyline_section.right, {
    LineInfo = {
      provider = "LineColumn",
      separator = " |",
      separator_highlight = { colors.fg, colors.bg },
      highlight = { colors.fg, colors.bg },
    },
  })

  table.insert(galaxyline_section.right, {
    PerCent = {
      provider = "LinePercent",
      separator = " |",
      separator_highlight = { colors.fg, colors.bg },
      highlight = { colors.fg, colors.bg },
    },
  })

  table.insert(galaxyline_section.short_line_left, {
    BufferType = {
      provider = function()
        return vim.bo.filetype
      end,
      highlight = { colors.fg, colors.bg },
    },
  })

  table.insert(galaxyline_section.short_line_right, {
    LineInfo = {
      provider = "LineColumn",
      highlight = { colors.fg, colors.bg },
    },
  })
end

return M

local M = {}

M.setup = function()
  local status_ok, indent_blankline = pcall(require, "indent_blankline")
  if not status_ok then
    return
  end

  indent_blankline.setup {
    use_treesitter = true,
    show_current_context = false,
    show_first_indent_level = true,
    show_trailing_blankline_indent = false,
    filetype_exclude = {
      "help",
      "terminal",
    },
    buftype_exclude = {
      "terminal",
    },
    char = "▏",
  }
end

return M

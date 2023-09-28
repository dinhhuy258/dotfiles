local M = {}

M.setup = function()
  local status_ok, ibl = pcall(require, "ibl")
  if not status_ok then
    return
  end

  ibl.setup {
    scope = {
      enabled = false,
    },
    exclude = {
      filetype = {
        "help",
        "terminal",
        "startify",
        "sfm",
      },
      buftype = {
        "terminal",
      },
    },
    indent = {
      char = "▏",
      tab_char = "▏",
    },
  }
end

return M

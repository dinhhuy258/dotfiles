local M = {}

M.setup = function()
  local status_ok, better_escape = pcall(require, "better_escape")
  if not status_ok then
    return
  end

  better_escape.setup {
    mapping = { "jj" },
    timeout = 100, -- the time in which the keys must be hit in ms
    clear_empty_lines = false,
    keys = "<Esc>",
  }
end

return M

local M = {}

M.setup = function()
  local status_ok, git = pcall(require, "git")
  if not status_ok then
    return
  end

  git.setup {
    winbar = true,
  }
end

return M

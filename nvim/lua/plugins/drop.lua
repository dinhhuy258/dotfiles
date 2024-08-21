local M = {}

function M.setup()
  local drop_ok, drop = pcall(require, "drop")
  if not drop_ok then
    return
  end

  drop.setup {
    theme = "xmas",
    filetypes = {
      "startify",
    },
  }
end

return M

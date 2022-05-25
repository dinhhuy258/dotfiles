local M = {}

function M.setup()
  local go_ok, go = pcall(require, "go-tools")
  if not go_ok then
    return
  end

  go.setup()
end

return M

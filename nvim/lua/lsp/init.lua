local handlers = require "lsp.handlers"
local mason = require "lsp.mason"

local M = {}

function M.setup()
  handlers.setup()
  mason.setup()
end

return M

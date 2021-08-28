local M = {}

function M.setup()
  local go_lsp_ok, go_lsp = pcall(require, "go-tools.lsp")
  local go_ok, go = pcall(require, "go-tools")
  if not go_lsp_ok or not go_ok then
    return
  end

  local lsp = require "lsp"

  go.setup()
  go_lsp.setup(function(_, bufnr)
    lsp.common_on_attach(_, bufnr)
    require("utils").buf_set_keymap(
      bufnr,
      "n",
      "<Leader>cf",
      "<CMD>lua require('go-tools.format').format()<CR>",
      { noremap = true, silent = true }
    )
  end, lsp.common_capabilities(), lsp.common_on_init)
end

return M

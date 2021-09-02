local M = {}

function M.config(_, _, _)
  lsp_clients["sql"] = {
    lsp = {
      provider = "sqls",
      setup = {
        cmd = { "sqls" },
      },
    },
  }
end

return M

local M = {}

function M.config(_, _, _)
  lsp_clients['sql'] = {
    formatters = {
      {
        -- @usage can be sqlformat
        exe = "",
        args = {},
      },
    },
    lsp = {
      provider = "sqls",
      setup = {
        cmd = { "sqls" },
        filetypes = { "sql" },
      },
    },
  }
end

return M

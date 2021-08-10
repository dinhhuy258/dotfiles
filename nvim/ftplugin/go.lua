require("lsp").setup "go"

local status_ok, dap = pcall(require, "dap")
if not status_ok then
  return
end

dap.adapters.go = {
  type = "executable",
  command = "node",
  args = { vim.fn.stdpath "data" .. "/dapinstall/golang/vscode-go/dist/debugAdapter.js" },
}

dap.configurations.go = {
  {
    type = "go",
    name = "Debug",
    request = "launch",
    showLog = false,
    program = "${file}",
    dlvToolPath = vim.fn.exepath "dlv",
  },
  {
    type = "go",
    name = "Debug test",
    request = "launch",
    showLog = false,
    mode = "test",
    program = "${file}",
    dlvToolPath = vim.fn.exepath "dlv",
  },
}

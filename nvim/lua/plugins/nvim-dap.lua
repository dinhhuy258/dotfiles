local M = {}

M.setup = function()
  -- Adapter configuration and installation instructions:
  -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
  local status_ok, dap = pcall(require, "dap")
  if not status_ok then
    return
  end

  vim.fn.sign_define("DapBreakpoint", {
    text = "",
    texthl = "LspDiagnosticsSignError",
    linehl = "",
    numhl = "",
  })

  dap.defaults.fallback.terminal_win_cmd = "50vsplit new"

  local utils = require "utils"
  local opts = { noremap = false }

  utils.set_keymap("n", "<Leader>ds", "<CMD>lua require'dap'.continue()<CR>", opts) -- Start
  utils.set_keymap("n", "<Leader>dq", "<CMD>lua require'dap'.close()<CR>", opts) -- Quit
  utils.set_keymap("n", "<Leader>dd", "<CMD>lua require'dap'.disconnect()<CR>", opts) -- Disconnect
  utils.set_keymap("n", "<Leader>dt", "<CMD>lua require'dap'.toggle_breakpoint()<CR>", opts) -- Toogle breakpoint
  utils.set_keymap("n", "<Leader>dC", "<CMD>lua require'dap'.run_to_cursor()<CR>", opts) -- Run to cursor
  utils.set_keymap("n", "<Leader>dn", "<CMD>lua require'dap'.step_over()<CR>", opts) -- Step over
  utils.set_keymap("n", "<Leader>db", "<CMD>lua require'dap'.step_back()<CR>", opts) -- Step back
  utils.set_keymap("n", "<Leader>di", "<CMD>lua require'dap'.step_into()<CR>", opts) -- Step into
  utils.set_keymap("n", "<Leader>dO", "<CMD>lua require'dap'.step_out()<CR>", opts) -- Step out
  utils.set_keymap("n", "<Leader>dp", "<CMD>lua require'dap'.pause.toggle()<CR>", opts) -- Pause
  utils.set_keymap("n", "<Leader>dc", "<CMD>lua require'dap'.continue()<CR>", opts) -- Continue
  utils.set_keymap("n", "<Leader>dr", "<CMD>lua require'dap'.session()<CR>", opts) -- Get session
  utils.set_keymap("n", "<Leader>dg", "<CMD>lua require'dap'.repl.toggle()<CR>", opts) -- Toggle repl
end

return M

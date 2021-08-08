local M = {}

M.setup = function()
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
  local opts1 = { noremap = false }

  utils.set_keymap("n", "<Leader>ds", "<CMD>lua require'dap'.continue()<CR>", opts1) -- Start
  utils.set_keymap("n", "<Leader>dq", "<CMD>lua require'dap'.close()<CR>", opts1) -- Quit
  utils.set_keymap("n", "<Leader>dd", "<CMD>lua require'dap'.disconnect()<CR>", opts1) -- Disconnect
  utils.set_keymap("n", "<Leader>dt", "<CMD>lua require'dap'.toggle_breakpoint()<CR>", opts1) -- Toogle breakpoint
  utils.set_keymap("n", "<Leader>dC", "<CMD>lua require'dap'.run_to_cursor()<CR>", opts1) -- Run to cursor
  utils.set_keymap("n", "<Leader>dn", "<CMD>lua require'dap'.step_over()<CR>", opts1) -- Step over
  utils.set_keymap("n", "<Leader>db", "<CMD>lua require'dap'.step_back()<CR>", opts1) -- Step back
  utils.set_keymap("n", "<Leader>di", "<CMD>lua require'dap'.step_into()<CR>", opts1) -- Step into
  utils.set_keymap("n", "<Leader>dO", "<CMD>lua require'dap'.step_out()<CR>", opts1) -- Step out
  utils.set_keymap("n", "<Leader>dp", "<CMD>lua require'dap'.pause.toggle()<CR>", opts1) -- Pause
  utils.set_keymap("n", "<Leader>dc", "<CMD>lua require'dap'.continue()<CR>", opts1) -- Continue
  utils.set_keymap("n", "<Leader>dr", "<CMD>lua require'dap'.session()<CR>", opts1) -- Get session
  utils.set_keymap("n", "<Leader>dg", "<CMD>lua require'dap'.repl.toggle()<CR>", opts1) -- Toggle repl
end

return M

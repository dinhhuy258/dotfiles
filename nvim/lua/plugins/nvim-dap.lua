local keymaps = require "config.keymaps"
local icons = require "icons"

local M = {}

M.setup = function()
  -- Adapter configuration and installation instructions:
  -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
  local status_ok, dap = pcall(require, "dap")
  if not status_ok then
    return
  end

  vim.fn.sign_define("DapBreakpoint", {
    text = icons.dap.breakpoint,
    texthl = "DiagnosticSignError",
    linehl = "",
    numhl = "",
  })

  dap.defaults.fallback.terminal_win_cmd = "50vsplit new"

  local opts = { noremap = false }

  keymaps.set("n", "<Leader>ds", "<CMD>lua require'dap'.continue()<CR>", opts) -- Start
  keymaps.set("n", "<Leader>dq", "<CMD>lua require'dap'.close()<CR>", opts) -- Quit
  keymaps.set("n", "<Leader>dd", "<CMD>lua require'dap'.disconnect()<CR>", opts) -- Disconnect
  keymaps.set("n", "<Leader>dt", "<CMD>lua require'dap'.toggle_breakpoint()<CR>", opts) -- Toogle breakpoint
  keymaps.set("n", "<Leader>dC", "<CMD>lua require'dap'.run_to_cursor()<CR>", opts) -- Run to cursor
  keymaps.set("n", "<Leader>dn", "<CMD>lua require'dap'.step_over()<CR>", opts) -- Step over
  keymaps.set("n", "<Leader>db", "<CMD>lua require'dap'.step_back()<CR>", opts) -- Step back
  keymaps.set("n", "<Leader>di", "<CMD>lua require'dap'.step_into()<CR>", opts) -- Step into
  keymaps.set("n", "<Leader>do", "<CMD>lua require'dap'.step_out()<CR>", opts) -- Step out
  keymaps.set("n", "<Leader>dp", "<CMD>lua require'dap'.pause.toggle()<CR>", opts) -- Pause
  keymaps.set("n", "<Leader>dc", "<CMD>lua require'dap'.continue()<CR>", opts) -- Continue
  keymaps.set("n", "<Leader>dr", "<CMD>lua require'dap'.session()<CR>", opts) -- Get session
  keymaps.set("n", "<Leader>dg", "<CMD>lua require'dap'.repl.toggle()<CR>", opts) -- Toggle repl
end

return M

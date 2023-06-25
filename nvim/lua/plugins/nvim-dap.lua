local keymap = require "utils.keymap"

local M = {}

M.setup = function()
  -- Adapter configuration and installation instructions:
  -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
  local status_ok, dap = pcall(require, "dap")
  if not status_ok then
    return
  end

  vim.fn.sign_define("DapBreakpoint", {
    text = "󰃤",
    texthl = "LspDiagnosticsSignError",
    linehl = "",
    numhl = "",
  })

  dap.defaults.fallback.terminal_win_cmd = "50vsplit new"

  local opts = { noremap = false }

  keymap.set("n", "<Leader>ds", "<CMD>lua require'dap'.continue()<CR>", opts) -- Start
  keymap.set("n", "<Leader>dq", "<CMD>lua require'dap'.close()<CR>", opts) -- Quit
  keymap.set("n", "<Leader>dd", "<CMD>lua require'dap'.disconnect()<CR>", opts) -- Disconnect
  keymap.set("n", "<Leader>dt", "<CMD>lua require'dap'.toggle_breakpoint()<CR>", opts) -- Toogle breakpoint
  keymap.set("n", "<Leader>dC", "<CMD>lua require'dap'.run_to_cursor()<CR>", opts) -- Run to cursor
  keymap.set("n", "<Leader>dn", "<CMD>lua require'dap'.step_over()<CR>", opts) -- Step over
  keymap.set("n", "<Leader>db", "<CMD>lua require'dap'.step_back()<CR>", opts) -- Step back
  keymap.set("n", "<Leader>di", "<CMD>lua require'dap'.step_into()<CR>", opts) -- Step into
  keymap.set("n", "<Leader>do", "<CMD>lua require'dap'.step_out()<CR>", opts) -- Step out
  keymap.set("n", "<Leader>dp", "<CMD>lua require'dap'.pause.toggle()<CR>", opts) -- Pause
  keymap.set("n", "<Leader>dc", "<CMD>lua require'dap'.continue()<CR>", opts) -- Continue
  keymap.set("n", "<Leader>dr", "<CMD>lua require'dap'.session()<CR>", opts) -- Get session
  keymap.set("n", "<Leader>dg", "<CMD>lua require'dap'.repl.toggle()<CR>", opts) -- Toggle repl

  require("general.autocmds").define_augroups {
    _nvim_dap = {
      {
        "FileType",
        "dap-repl",
        "set nobuflisted",
      },
    },
  }
end

return M

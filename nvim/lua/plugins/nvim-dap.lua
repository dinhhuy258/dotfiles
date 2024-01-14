local keymaps = require "config.keymaps"
local icons = require "icons"

local M = {}

local function setup_dap_ruby()
  local status_ok, dap_ruby = pcall(require, "dap-ruby")
  if not status_ok then
    return
  end

  dap_ruby.setup()
end

local function setup_dap_ui()
  local dap_status_ok, dap = pcall(require, "dap")
  if not dap_status_ok then
    return
  end

  local dap_ui_status_ok, dapui = pcall(require, "dapui")
  if not dap_ui_status_ok then
    return
  end

  dapui.setup {
    controls = {
      element = "repl",
      enabled = true,
      icons = {
        disconnect = icons.dap.disconnect,
        pause = icons.dap.pause,
        play = icons.dap.play,
        run_last = icons.dap.run_last,
        step_back = icons.dap.step_back,
        step_into = icons.dap.step_into,
        step_out = icons.dap.step_out,
        step_over = icons.dap.step_over,
        terminate = icons.dap.terminate,
      },
    },
    element_mappings = {},
    expand_lines = false,
    floating = {
      border = "rounded",
      mappings = {
        close = { "q", "<Esc>" },
      },
    },
    force_buffers = true,
    icons = {
      collapsed = icons.dap.collapsed,
      current_frame = icons.dap.current_frame,
      expanded = icons.dap.expanded,
    },
    layouts = {
      {
        elements = {
          {
            id = "breakpoints",
            size = 0.25,
          },
          {
            id = "stacks",
            size = 0.25,
          },
          {
            id = "scopes",
            size = 0.5,
          },
        },
        position = "right",
        size = 40,
      },
      {
        elements = { {
          id = "repl",
          size = 1,
        } },
        position = "bottom",
        size = 10,
      },
    },
    mappings = {
      edit = "e",
      expand = { "<CR>" },
      open = "o",
      remove = "d",
      repl = "r",
      toggle = "t",
    },
    render = {
      indent = 1,
      max_value_lines = 100,
    },
  }

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end

  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end

  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
end

local function setup_dap()
  -- Adapter configuration and installation instructions:
  -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
  local dap_status_ok, dap = pcall(require, "dap")
  if not dap_status_ok then
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

M.setup = function()
  setup_dap()
  setup_dap_ui()
  setup_dap_ruby()
end

return M

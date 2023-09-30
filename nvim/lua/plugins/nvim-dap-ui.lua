local icons = require "icons"

local M = {}

M.setup = function()
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

return M

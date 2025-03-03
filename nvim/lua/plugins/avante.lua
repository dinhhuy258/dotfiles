local M = {}

M.setup = function()
  local status_ok, avante = pcall(require, "avante")
  if not status_ok then
    return
  end

  local avante_api = require "avante.api"

  avante.setup {
    provider = "copilot",
    behaviour = {
      auto_suggestions = false,
      auto_set_keymaps = false,
    },
    hints = { enabled = false },
    copilot = {
      model = "claude-3.7-sonnet",
      temperature = 0,
      max_tokens = 8192,
    },
    mappings = {},
  }

  local wk = require "which-key"
  wk.add {
    { "<Leader>i", mode = "n", group = "AI" },
    {
      "<Leader>it",
      function()
        avante_api.toggle()
      end,
      desc = "Show sidebar",
      mode = "n",
    },
    {
      "<Leader>ir",
      function()
        avante_api.refresh()
      end,
      desc = "Refresh sidebar",
      mode = "n",
    },
    {
      "<Leader>ia",
      function()
        avante_api.ask()
      end,
      desc = "Ask",
      mode = { "n", "x" },
    },
    {
      "<Leader>ie",
      function()
        avante_api.edit()
      end,
      desc = "Edit",
      mode = { "n", "x" },
    },
    {
      "<Leader>i?",
      function()
        avante_api.select_model()
      end,
      desc = "Select model",
      mode = "n",
    },
  }
end

return M

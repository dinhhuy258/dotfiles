local M = {}

M.setup = function()
  local status_ok, avante = pcall(require, "avante")
  if not status_ok then
    return
  end

  local avante_api = require "avante.api"

  avante.setup {
    system_prompt = function()
      local hub = require("mcphub").get_hub_instance()
      return hub and hub:get_active_servers_prompt() or ""
    end,
    custom_tools = function()
      return {
        require("mcphub.extensions.avante").mcp_tool(),
      }
    end,
    instructions_file = "CLAUDE.md",
    provider = "copilot",
    providers = {
      copilot = {
        model = "claude-sonnet-4.5",
      },
    },
    behaviour = {
      auto_suggestions = false,
      auto_set_keymaps = false,
    },
    selection = { enabled = false },
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
      "<CMD>AvanteClear<CR>",
      desc = "Clear the chat history for your current chat session	",
      mode = "n",
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
      "<Leader>is",
      function()
        avante_api.stop()
      end,
      desc = "Stop the current AI request",
      mode = "n",
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

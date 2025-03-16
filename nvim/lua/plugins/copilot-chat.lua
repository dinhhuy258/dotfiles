local M = {}

M.setup = function()
  local status_ok, copilot_chat = pcall(require, "CopilotChat")
  if not status_ok then
    return
  end

  copilot_chat.setup {
    model = "claude-3.7-sonnet",
  }

  local wk = require "which-key"
  wk.add {
    { "<Leader>i", mode = "n", group = "AI" },
    {
      "<Leader>it",
      function()
        copilot_chat.toggle()
      end,
      desc = "Toggle chat window",
      mode = "n",
    },
    {
      "<Leader>ip",
      function()
        copilot_chat.prompts()
      end,
      desc = "View/select prompt templates",
      mode = "n",
    },
    {
      "<Leader>is",
      function()
        copilot_chat.stop()
      end,
      desc = "Stop current output",
      mode = "n",
    },
    {
      "<Leader>ir",
      function()
        copilot_chat.reset()
      end,
      desc = "Reset chat window",
      mode = "n",
    },
    {
      "<Leader>i?",
      function()
        copilot_chat.select_model()
      end,
      desc = "View/select available models",
      mode = "n",
    },
  }
end

return M

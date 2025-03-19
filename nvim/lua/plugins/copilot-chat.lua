local icons = require "icons"

local M = {}

M.setup = function()
  local status_ok, copilot_chat = pcall(require, "CopilotChat")
  if not status_ok then
    return
  end

  local prompts = {
    Explain = "Please explain how the following code works.",
    Review = "Please review the following code and provide suggestions for improvement.",
    Tests = "Please explain how the selected code works, then generate unit tests for it.",
    Refactor = "Please refactor the following code to improve its clarity and readability.",
  }

  copilot_chat.setup {
    model = "claude-3.7-sonnet",
    prompts = prompts,
    question_header = icons.copilot_chat.user .. " dinhhuy258 ",
    answer_header = icons.copilot_chat.copilot .. " Copilot ",
    highlight_headers = false,
    separator = "---",
    error_header = "> [!ERROR] Error",
    mappings = {
      accept_diff = {
        normal = "ga",
        insert = "",
      },
      reset = {
        normal = "",
        insert = "",
      },
      submit_prompt = {
        normal = "<CR>",
        insert = "",
      },
    },
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
      "<Cmd>CopilotChatPrompt<CR>",
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

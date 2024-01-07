local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local keymaps = require "config.keymaps"

local M = {}

local git_tasks = {
  {
    title = "󰊢 Checkout main branch",
    command = "gcm",
    type = "vimux",
  },
  {
    title = "󰊢 Checkout dev branch",
    command = "gcd",
    type = "vimux",
  },
  {
    title = "󰊢 Create branch",
    command = "gcb",
    prompt = "Branch name:",
    type = "input",
  },
  {
    title = "󰊢 Git pull",
    command = "ggl",
    type = "vimux",
  },
  {
    title = "󰊢 Git push",
    command = "ggp",
    type = "vimux",
  },
  {
    title = "󰊢 Git force push",
    command = "ggf",
    type = "vimux",
  },
  {
    title = "󰊢 Git delete local merged branches",
    command = "gdlm",
    type = "vimux",
  },
}

local go_tasks = {
  {
    title = " Start go server",
    command = "make up",
    type = "vimux",
  },
  {
    title = "󰍉 Run go lint",
    command = "make lint",
    type = "vimux",
  },
  {
    title = "󰍉 Run go test",
    command = "make test",
    type = "vimux",
  },
  {
    title = "󰱧 Go mod tidy",
    command = "go mod tidy",
    type = "vimux",
  },
}

local php_tasks = {
  {
    title = " Start php server",
    command = "./vendor/bin/sail up",
    type = "vimux",
  },
  {
    title = "󰍉 Run php lint",
    command = "./vendor/bin/pint",
    type = "vimux",
  },
  {
    title = "󰈙 Generate php swagger",
    command = "./vendor/bin/sail artisan l5-swagger:generate",
    type = "vimux",
  },
}

local common_tasks = {
  {
    title = "󰱽 Search config file",
    command = 'Telescope find_files search_dirs={"~/.config"}',
  },
  {
    title = "󰅙 Interupt current vimux job",
    command = "VimuxInterruptRunner",
  },
  {
    title = "󰅙 Close vimux pannel",
    command = "VimuxCloseRunner",
  },
}

local file_type_tasks = {
  go = go_tasks,
  php = php_tasks,
}

local function run_tasks(tasks, opts)
  opts = opts or {}
  pickers
    .new(opts, {
      prompt_title = "Tasks",
      finder = finders.new_table {
        results = tasks,
        entry_maker = function(task)
          return {
            value = task,
            display = task.title,
            ordinal = task.title,
          }
        end,
      },
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          local selection_value = selection.value
          local command = selection_value.command
          if command then
            local type = selection_value.type
            if type == "vimux" then
              vim.cmd("VimuxRunCommand " .. '"' .. command .. '"')
            elseif type == "input" then
              local prompt = "Input:"
              if selection_value.prompt then
                prompt = selection_value.prompt
              end

              require("core.float_input").input(function(input)
                local cmd = command .. " " .. input
                vim.cmd("VimuxRunCommand " .. '"' .. cmd .. '"')
              end, {
                prompt = prompt,
              })
            else
              vim.cmd(command)
            end
          end
        end)

        return true
      end,
    })
    :find()
end

function M.setup()
  keymaps.set("n", "<leader>rr", function()
    require("core.float_input").input(function(input)
      vim.cmd("VimuxRunCommand " .. '"' .. input .. '"')
    end, {
      prompt = "Command:",
    })
  end)

  keymaps.set("n", "<leader>r.", ":VimuxRunLastCommand<CR>")

  keymaps.set("n", "<leader>rq", ":VimuxInterruptRunner<CR>")

  keymaps.set("n", "<leader>c", ":VimuxCloseRunner<CR>")

  keymaps.set("n", "<leader>rt", function()
    -- get current file type
    local file_type = vim.bo.filetype
    local tasks = file_type_tasks[file_type] or {}

    run_tasks(tasks, require("telescope.themes").get_dropdown {})
  end)

  keymaps.set("n", "<leader>rc", function()
    run_tasks(common_tasks, require("telescope.themes").get_dropdown {})
  end)

  keymaps.set("n", "<leader>rg", function()
    run_tasks(git_tasks, require("telescope.themes").get_dropdown {})
  end)

  keymaps.set("n", "<leader>ra", function()
    -- get all tasks from all file types
    local tasks = {}
    for _, file_type_task in pairs(file_type_tasks) do
      for _, task in pairs(file_type_task) do
        table.insert(tasks, task)
      end
    end

    -- get all common tasks
    for _, task in pairs(common_tasks) do
      table.insert(tasks, task)
    end

    run_tasks(tasks, require("telescope.themes").get_dropdown {})
  end)
end

return M

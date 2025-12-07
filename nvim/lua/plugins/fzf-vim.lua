local keymaps = require "config.keymaps"

local M = {}

vim.env.FZF_DEFAULT_OPTS = (vim.env.FZF_DEFAULT_OPTS or "") .. " --layout=reverse"

-- Custom function for git branch switching
local function git_branches()
  vim.fn["fzf#run"](vim.fn["fzf#wrap"] {
    source = "git branch -a | grep -v HEAD",
    sink = function(branch)
      local branch_name = vim.trim(branch):gsub("^[* ]+", ""):gsub("^remotes/origin/", "")
      vim.cmd("Git checkout " .. branch_name)
    end,
    options = {
      "--prompt",
      "Branches> ",
      "--preview",
      'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {} | head -200',
      "--preview-window",
      "down:50%",
    },
  })
end

M.setup = function()
  -- fzf.vim global configuration

  -- Set preview window (bottom, 50% height, toggle with ctrl-/)
  vim.g.fzf_vim = {
    preview_window = { "down:50%", "ctrl-/" },
    buffers_jump = 1, -- Jump to existing window if possible
  }

  -- Customize fzf layout
  vim.g.fzf_layout = {
    window = {
      width = 0.9,
      height = 0.8,
      border = "rounded",
    },
  }

  -- Custom actions for splits
  -- fzf.vim default: ctrl-x (horizontal), ctrl-v (vertical)
  -- To match current workflow (ctrl-h, ctrl-v), remap in fzf options
  vim.g.fzf_action = {
    ["ctrl-t"] = "tab split",
    ["ctrl-h"] = "split", -- horizontal split
    ["ctrl-v"] = "vsplit", -- vertical split
  }

  -- Rg command with additional options
  vim.cmd [[
    command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case --hidden --glob "!.git/" '.shellescape(<q-args>),
      \   1,
      \   fzf#vim#with_preview(),
      \   <bang>0)
  ]]

  -- Keybindings
  keymaps.set("n", "<Leader>ff", ":Files<CR>", { noremap = true, silent = true })
  keymaps.set("n", "<Leader>fb", ":Buffers<CR>", { noremap = true, silent = true })
  keymaps.set("n", "<Leader>fg", ":GFiles?<CR>", { noremap = true, silent = true })
  keymaps.set("n", "<Leader>fc", git_branches, { noremap = true, silent = true })
  keymaps.set("n", "<Leader>fh", ":History:<CR>", { noremap = true, silent = true })
  keymaps.set("n", "<Leader>fr", ":Rg<CR>", { noremap = true, silent = true })

  -- Additional useful fzf.vim commands
  keymaps.set("n", "<Leader>f/", ":History/<CR>", { noremap = true, silent = true }) -- search history
  keymaps.set("n", "<Leader>fm", ":Marks<CR>", { noremap = true, silent = true }) -- marks
  keymaps.set("n", "<Leader>fw", ":Windows<CR>", { noremap = true, silent = true }) -- windows
end

return M

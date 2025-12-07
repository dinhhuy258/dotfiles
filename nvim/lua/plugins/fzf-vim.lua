local keymaps = require "config.keymaps"

local M = {}

vim.env.FZF_DEFAULT_OPTS = (vim.env.FZF_DEFAULT_OPTS or "") .. " --layout=reverse"

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

local function interactive_rg(query)
  query = query or ""
  local base_command = "rg --column --line-number --no-heading --color=always --smart-case"
  local fallback = " || :"

  -- Parse query to extract rg options (e.g., --iglob, --type-add, etc.)
  local function parse_query(q)
    local search_term = ""
    local rg_options = ""

    -- Match patterns like --iglob=*.go or --iglob '*.go' or --type go
    local option_pattern = "(%-%-[%w%-]+[=%s][^%s]+)"

    local remaining = q
    -- Extract options with values
    for option in remaining:gmatch(option_pattern) do
      rg_options = rg_options .. " " .. option
      remaining = remaining:gsub(vim.pesc(option), "", 1)
    end

    -- Extract simple flags (like --hidden, --no-ignore)
    for word in remaining:gmatch "%S+" do
      if word:match "^%-%-[%w%-]+$" then
        rg_options = rg_options .. " " .. word
        remaining = remaining:gsub(vim.pesc(word), "", 1)
      end
    end

    search_term = vim.trim(remaining)
    rg_options = vim.trim(rg_options)

    return search_term, rg_options
  end

  -- Build reload command with proper option placement
  local function build_reload_cmd(q)
    local search_term, rg_options = parse_query(q)
    local cmd = base_command
    if rg_options ~= "" then
      cmd = cmd .. " " .. rg_options
    end
    cmd = cmd .. " --"
    -- If no search term, use a pattern that matches everything
    if search_term ~= "" then
      cmd = cmd .. " " .. vim.fn.shellescape(search_term)
    else
      cmd = cmd .. " ''"
    end

    return cmd
  end

  local opts = {
    source = ":",
    options = {
      "--ansi",
      "--prompt",
      "Rg> ",
      "--query",
      query,
      "--disabled",
      "--multi",
      "--bind",
      "ctrl-i:transform:[[ {q} =~ --iglob[[:space:]]*$ ]] && echo 'change-query({q})' || echo 'change-query({q} --iglob )'",
      "--delimiter",
      ":",
      "--preview-window",
      "+{2}/2",
      "--bind",
      "start:reload:" .. build_reload_cmd(query),
      "--bind",
      "change:reload:" .. build_reload_cmd "{q}" .. fallback,
    },
    ["sink*"] = function(selections)
      if #selections < 1 then
        return
      end

      -- Parse the ripgrep output: file:line:column:content
      local parts = vim.split(selections[1], ":", { plain = true })
      if #parts >= 3 then
        local file = parts[1]
        local lnum = tonumber(parts[2])
        local col = tonumber(parts[3]) or 1

        vim.cmd("edit " .. vim.fn.fnameescape(file))
        if lnum then
          vim.api.nvim_win_set_cursor(0, { lnum, col - 1 })
          vim.cmd "normal! zz"
        end
      end
    end,
  }

  vim.fn["fzf#run"](vim.fn["fzf#wrap"]("rg", opts, 0))
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
  keymaps.set("n", "<Leader>fg", ":GFiles?<CR>", { noremap = true, silent = true })
  keymaps.set("n", "<Leader>fc", git_branches, { noremap = true, silent = true })
  keymaps.set("n", "<Leader>fh", ":History:<CR>", { noremap = true, silent = true })
  keymaps.set("n", "<Leader>fr", interactive_rg, { noremap = true, silent = true })

  -- Additional useful fzf.vim commands
  keymaps.set("n", "<Leader>f/", ":History/<CR>", { noremap = true, silent = true }) -- search history
  keymaps.set("n", "<Leader>fw", ":Windows<CR>", { noremap = true, silent = true }) -- windows
end

return M

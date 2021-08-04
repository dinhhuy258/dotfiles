local M = {}

M.setup = function()
  local fzf_status_ok, fzf = pcall(require, "fzf-lua")
  if not fzf_status_ok then
    return
  end

  local fzf_actions_status_ok, actions = pcall(require, "fzf-lua.actions")
  if not fzf_actions_status_ok then
    return
  end

  fzf.setup {
    winopts = {
      win_height = 0.85, -- window height
      win_width = 0.80, -- window width
      win_row = 0.30, -- window row position (0=top, 1=bottom)
      win_col = 0.50, -- window col position (0=left, 1=right)
      -- win_border    = false,           -- window border? or borderchars?
      win_border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      window_on_create = function() -- nvim window options override
        vim.cmd "set winhl=Normal:Normal"
      end,
    },
    fzf_layout = "reverse", -- fzf '--layout='
    fzf_args = "", -- adv: fzf extra args, empty unless adv
    fzf_binds = { -- fzf '--bind=' options
      "ctrl-d:half-page-down",
      "ctrl-u:half-page-up",
      "ctrl-f:page-down",
      "ctrl-b:page-up",
      "ctrl-a:toggle-all",
      "ctrl-l:clear-query",
    },
    preview_cmd = "", -- 'head -n $FZF_PREVIEW_LINES',
    preview_border = "border", -- border|noborder
    preview_wrap = "nowrap", -- wrap|nowrap
    preview_opts = "nohidden", -- hidden|nohidden
    preview_vertical = "down:60%", -- up|down:size
    -- preview_horizontal  = 'right:60%',  -- right|left:size
    preview_layout = "vertical", -- horizontal|vertical|flex
    -- flip_columns        = 120,            -- #cols to switch to horizontal on flex
    bat_theme = "Visual Studio Dark+", -- bat preview theme (bat --list-themes)
    -- provider setup
    files = {
      prompt = "Files❯ ",
      cmd = "", -- "find . -type f -printf '%P\n'",
      git_icons = true, -- show git icons?
      file_icons = true, -- show file icons?
      color_icons = true, -- colorize file|git icons
      actions = {
        ["default"] = actions.file_edit,
        ["ctrl-h"] = actions.file_split,
        ["ctrl-v"] = actions.file_vsplit,
        ["ctrl-t"] = actions.file_tabedit,
        ["ctrl-q"] = actions.file_sel_to_qf,
        ["ctrl-y"] = function(selected)
          print(selected[2])
        end,
      },
    },
    git = {
      prompt = "GitFiles❯ ",
      cmd = "git -c color.status=always status --short --untracked-files=all",
      git_icons = true, -- show git icons?
      file_icons = true, -- show file icons?
      color_icons = true, -- colorize file|git icons
      icons = {
        ["M"] = { icon = "M", color = "yellow" },
        ["D"] = { icon = "D", color = "red" },
        ["A"] = { icon = "A", color = "green" },
        ["?"] = { icon = "?", color = "magenta" },
        -- ["M"]          = { icon = "★", color = "red" },
        -- ["D"]          = { icon = "✗", color = "red" },
        -- ["A"]          = { icon = "+", color = "green" },
      },
    },
    grep = {
      prompt = "Rg❯ ",
      input_prompt = "Grep For❯ ",
      -- cmd               = "rg --vimgrep",
      rg_opts = "--hidden --column --line-number --no-heading "
        .. "--color=always --smart-case -g '!{.git,node_modules}/*'",
      git_icons = true, -- show git icons?
      file_icons = true, -- show file icons?
      color_icons = true, -- colorize file|git icons
      actions = {
        ["default"] = actions.file_edit,
        ["ctrl-h"] = actions.file_split,
        ["ctrl-v"] = actions.file_vsplit,
        ["ctrl-t"] = actions.file_tabedit,
        ["ctrl-q"] = actions.file_sel_to_qf,
        ["ctrl-y"] = function(selected)
          print(selected[2])
        end,
      },
    },
    oldfiles = {
      prompt = "History❯ ",
      cwd_only = false,
    },
    buffers = {
      prompt = "Buffers❯ ",
      file_icons = true, -- show file icons?
      color_icons = true, -- colorize file|git icons
      sort_lastused = true, -- sort buffers() by last used
      actions = {
        ["default"] = actions.buf_edit,
        ["ctrl-h"] = actions.buf_split,
        ["ctrl-v"] = actions.buf_vsplit,
        ["ctrl-t"] = actions.buf_tabedit,
        ["ctrl-x"] = actions.buf_del,
      },
    },
    quickfix = {
      -- cwd               = vim.loop.cwd(),
      file_icons = true,
      git_icons = true,
    },
    lsp = {
      prompt = "❯ ",
      -- cwd               = vim.loop.cwd(),
      file_icons = true,
      git_icons = false,
      lsp_icons = true,
      severity = "hint",
      icons = {
        ["Error"] = { icon = "", color = "red" }, -- error
        ["Warning"] = { icon = "", color = "yellow" }, -- warning
        ["Information"] = { icon = "", color = "blue" }, -- info
        ["Hint"] = { icon = "", color = "magenta" }, -- hint
      },
    },
    -- placeholders for additional user customizations
    loclist = {},
    helptags = {},
    manpages = {},
    -- optional override of file extension icon colors
    -- available colors (terminal):
    --    clear, bold, black, red, green, yellow
    --    blue, magenta, cyan, grey, dark_grey, white
    file_icon_colors = {
      ["lua"] = "blue",
    },
  }

  local utils = require "utils"

  utils.set_keymap("n", "<Leader>fr", ":lua require('fzf-lua').live_grep()<CR>", { noremap = true })
  utils.set_keymap("n", "<Leader>fg", ":lua require('fzf-lua').git_files()<CR>", { noremap = true })
  utils.set_keymap("n", "<Leader>fb", ":lua require('fzf-lua').buffers()<CR>", { noremap = true })
  utils.set_keymap("n", "<Leader>fe", ":lua require('fzf-lua').oldfiles()<CR>", { noremap = true })
  utils.set_keymap("n", "<Leader>ff", ":lua require('fzf-lua').files()<CR>", { noremap = true })
end

return M

local keymaps = require "config.keymaps"
local icons = require "icons"

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
      win_border = icons.fzf.win_border,
      hl_normal = "Normal",
      hl_border = "FloatBorder",
    },
    keymap = {
      -- These override the default tables completely
      -- no need to set to `false` to disable a bind
      -- delete or modify is sufficient
      builtin = {
        -- neovim `:tmap` mappings for the fzf win
        ["<F2>"] = "toggle-fullscreen",
        -- Only valid with the 'builtin' previewer
        ["<F3>"] = "toggle-preview-wrap",
        ["<F4>"] = "toggle-preview",
        ["<S-down>"] = "preview-page-down",
        ["<S-up>"] = "preview-page-up",
        ["<S-left>"] = "preview-page-reset",
      },
      fzf = {
        -- fzf '--bind=' options
        ["ctrl-k"] = "unix-line-discard",
        ["ctrl-d"] = "half-page-down",
        ["ctrl-u"] = "half-page-up",
        ["ctrl-a"] = "beginning-of-line",
        ["ctrl-e"] = "end-of-line",
        ["alt-a"] = "toggle-all",
        -- Only valid with fzf previewers (bat/cat/git/etc)
        ["f3"] = "toggle-preview-wrap",
        ["f4"] = "toggle-preview",
        ["shift-down"] = "preview-page-down",
        ["shift-up"] = "preview-page-up",
      },
    },
    fzf_layout = "reverse", -- fzf '--layout='
    fzf_args = "", -- adv: fzf extra args, empty unless adv
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
  }

  keymaps.set("n", "<Leader>ff", ":lua require('fzf-lua').files()<CR>", { noremap = true })
end

return M

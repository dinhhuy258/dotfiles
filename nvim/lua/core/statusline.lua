local icons = require "icons"

local M = {}

local special_buftypes = {
  terminal = {
    name = "Terminal",
    icon = icons.statusline.buftype.terminal,
    show_section_right = false,
  },
}

local float_filetypes = {
  fzf = "fzf",
  floaterm = "floaterm",
}

local float_buftypes = {
  terminal = "terminal",
}

local special_filetypes = {
  sfm = {
    name = "File explorer",
    icon = icons.statusline.filetype.sfm,
    show_section_right = false,
  },
  fzf = {
    name = "fzf",
    icon = icons.statusline.filetype.fzf,
    show_section_right = false,
  },
  VimDatabase = {
    name = "Database",
    icon = icons.statusline.filetype.VimDatabase,
    show_section_right = true,
  },
  ["git.nvim"] = {
    name = "Git",
    icon = icons.statusline.filetype["git.nvim"],
    show_section_right = false,
  },
  diff = {
    name = "diff",
    icon = icons.statusline.filetype.diff,
    show_section_right = false,
  },
  floaterm = {
    name = "Terminal",
    icon = icons.statusline.filetype.floaterm,
    show_section_right = false,
  },
  startify = {
    name = "Startify",
    icon = icons.statusline.filetype.startify,
    show_section_right = true,
  },
  help = {
    name = "Help",
    icon = icons.statusline.filetype.help,
    show_section_right = true,
  },
}

local function buffer_is_empty()
  if vim.fn.empty(vim.fn.expand "%:t") ~= 1 then
    return false
  end
  return true
end

local function line_column_provider()
  local line = vim.fn.line "."
  local column = vim.fn.col "."
  return string.format("%3d :%2d", line, column)
end

local function separator_provider(separator)
  return separator
end

local function file_info_provider(buf, active)
  if buffer_is_empty() then
    return ""
  end

  local filename = vim.api.nvim_buf_get_name(buf)
  local f_name = vim.fn.fnamemodify(filename, ":~:.")

  local ok, devicons = pcall(require, "nvim-web-devicons")
  if not ok then
    return filename
  end

  local icon, icon_hl = devicons.get_icon(vim.fn.fnamemodify(filename, "%:t"), vim.fn.fnamemodify(filename, ":e"))

  if icon == nil then
    icon = icons.statusline.file.default .. " "
  else
    vim.cmd("hi StatuslineFileIcon guibg=NONE" .. " guifg=" .. vim.fn.synIDattr(vim.fn.hlID(icon_hl), "fg"))
    icon = "%#StatuslineFileIcon#" .. icon

    if active then
      icon = icon .. "%#StatusLine#"
    else
      icon = icon .. "%#StatusLineNC#"
    end
  end

  return icon .. " " .. f_name
end

local function special_filetype_provider(special_filetype)
  return special_filetype.icon .. " " .. special_filetype.name
end

local function git_branch_provider()
  local gsd = vim.b.gitsigns_status_dict

  if gsd and gsd.head and #gsd.head > 0 then
    return icons.statusline.git.branch .. " " .. gsd.head .. " | "
  end

  return ""
end

local function line_percent_provider()
  local current_line = vim.fn.line "."
  local total_line = vim.fn.line "$"
  if current_line == 1 then
    return " Top "
  elseif current_line == vim.fn.line "$" then
    return " Bot "
  end
  local result, _ = math.modf((current_line / total_line) * 100)
  return " " .. result .. "%% "
end

local function generate_statusline(winid, force_inactive)
  local statusline = ""
  local buf = vim.api.nvim_win_get_buf(winid)
  local active_win = vim.api.nvim_get_current_win()
  local active = winid == active_win
  if force_inactive == true then
    active = false
  end

  local current_ft = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(active_win), "ft")
  local current_bt = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(active_win), "bt")

  if (float_filetypes[current_ft] ~= nil or float_buftypes[current_bt]) and not active then
    return statusline
  end

  local special_filetype = special_filetypes[vim.api.nvim_buf_get_option(buf, "ft")]
  local special_buftype = special_buftypes[vim.api.nvim_buf_get_option(buf, "bt")]

  if active then
    statusline = "%#StatusLine#"
  else
    statusline = "%#StatusLineNC#"
  end

  -- Section left
  statusline = statusline .. separator_provider " "

  if special_filetype then
    statusline = statusline .. special_filetype_provider(special_filetype)

    if not special_filetype.show_section_right then
      return statusline
    end
  elseif special_buftype then
    statusline = statusline .. special_filetype_provider(special_buftype)

    if not special_buftype.show_section_right then
      return statusline
    end
  else
    statusline = statusline .. file_info_provider(buf, active)
  end

  if not active then
    return statusline
  end

  -- Section right
  statusline = statusline .. "%="
  statusline = statusline .. git_branch_provider()
  statusline = statusline .. line_column_provider()
  statusline = statusline .. separator_provider " |"
  statusline = statusline .. line_percent_provider()

  return statusline
end

local function create_augroup(autocmds, name)
  vim.cmd("augroup " .. name)
  vim.cmd "autocmd!"

  for _, autocmd in ipairs(autocmds) do
    vim.cmd("autocmd " .. table.concat(autocmd, " "))
  end

  vim.cmd "augroup END"
end

function M.statusline()
  return generate_statusline(vim.api.nvim_get_current_win(), false)
end

function M.update_active_window(force_inactive)
  if not force_inactive then
    vim.o.statusline = "%!v:lua.require'core.statusline'.statusline()"
  else
    local winid = vim.api.nvim_get_current_win()
    vim.wo[winid].statusline = generate_statusline(vim.api.nvim_get_current_win(), force_inactive)
  end
end

-- Update statusline of inactive windows on the current tabpage
function M.update_inactive_windows()
  -- Uses vim.schedule to defer executing the function until after
  -- all other autocommands have run. This will ensure that inactive windows
  -- are updated after any changes.
  vim.schedule(function()
    local current_win = vim.api.nvim_get_current_win()

    for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      if vim.api.nvim_win_get_config(winid).relative == "" and winid ~= current_win then
        vim.wo[winid].statusline = generate_statusline(winid, false)
      end
    end

    -- Reset local statusline of current window to use the global statusline for it
    vim.wo.statusline = nil
  end)
end

function M.setup()
  -- Ensures custom quickfix statusline isn't loaded
  vim.g.qf_disable_statusline = true
  vim.o.statusline = "%!v:lua.require'core.statusline'.statusline()"

  create_augroup({
    {
      "VimEnter,WinEnter,WinClosed,FileChangedShellPost",
      "*",
      "lua require'core.statusline'.update_inactive_windows()",
    },
    {
      "FocusGained",
      "*",
      "lua require'core.statusline'.update_active_window(false)",
    },
    {
      "FocusLost",
      "*",
      "lua require'core.statusline'.update_active_window(true)",
    },
  }, "core.statusline")
end

return M

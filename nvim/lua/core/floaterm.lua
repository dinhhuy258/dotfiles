local keymaps = require "config.keymaps"

local M = {}

local floaterm_win, floaterm_buf

local function is_open()
  if not floaterm_win then
    return false
  end

  return vim.fn.win_gotoid(floaterm_win) > 0 and vim.api.nvim_win_get_buf(floaterm_win) == floaterm_buf
end

local function close_floaterm_win()
  if floaterm_win then
    if vim.api.nvim_win_is_valid(floaterm_win) then
      vim.api.nvim_win_close(floaterm_win, true)
    end
  end
  floaterm_win = nil
end

local function close_floaterm_buf()
  if floaterm_buf then
    if vim.api.nvim_buf_is_valid(floaterm_buf) then
      vim.api.nvim_buf_delete(floaterm_buf, { force = true })
    end
  end
  floaterm_buf = nil
end

local function hide_floaterm()
  close_floaterm_win()
end

local function kill_floaterm()
  close_floaterm_win()
  close_floaterm_buf()
end

local function open_floaterm(cmd)
  local width = vim.api.nvim_get_option "columns"
  local height = vim.api.nvim_get_option "lines"
  local win_height = math.ceil(height * 0.8 - 4)
  local win_width = math.ceil(width * 0.8)
  local row = math.ceil((height - win_height) / 2 - 1)
  local col = math.ceil((width - win_width) / 2)

  local floaterm_opts = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    anchor = "NW",
    border = "single",
  }

  if floaterm_buf and vim.api.nvim_buf_is_valid(floaterm_buf) then
    floaterm_win = vim.api.nvim_open_win(floaterm_buf, true, floaterm_opts)
    vim.api.nvim_command "startinsert"
    return
  end

  floaterm_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(floaterm_buf, "buftype", "")
  vim.api.nvim_buf_set_option(floaterm_buf, "bufhidden", "hide")
  vim.api.nvim_buf_set_option(floaterm_buf, "swapfile", false)
  vim.api.nvim_buf_set_option(floaterm_buf, "filetype", "floaterm")

  floaterm_win = vim.api.nvim_open_win(floaterm_buf, true, {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    anchor = "NW",
    border = "single",
  })
  vim.api.nvim_win_set_option(floaterm_win, "winhl", "Normal:Normal")
  vim.api.nvim_win_set_option(floaterm_win, "cursorline", true)
  vim.api.nvim_win_set_option(floaterm_win, "colorcolumn", "")

  if cmd then
    vim.call("termopen", "bash -c " .. cmd)
  else
    vim.api.nvim_command "terminal"
  end
  vim.api.nvim_command "startinsert"
  -- This option should be set after terminal command
  vim.api.nvim_buf_set_option(floaterm_buf, "buflisted", false)

  vim.api.nvim_command "autocmd TermClose <buffer> ++once lua require'core.floaterm'.on_term_close()"
end

function M.on_floaterm_close()
  vim.api.nvim_command "silent checktime"
end

function M.on_term_close()
  M.on_floaterm_close()
  vim.schedule(function()
    kill_floaterm()
  end)
end

function M.new_floaterm(cmd)
  kill_floaterm()
  open_floaterm(cmd)
end

function M.toggle_floaterm()
  if is_open() then
    hide_floaterm()
    M.on_floaterm_close()
  else
    open_floaterm()
  end
end

function M.setup()
  keymaps.set("n", "<Leader>tg", function()
    M.new_floaterm "lazygit"
  end)
end

return M

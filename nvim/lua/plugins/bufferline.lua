local M = {}

function M.go_to_last()
  vim.cmd [[BufferLineGoToBuffer 1]]
  vim.cmd [[BufferLineCyclePrev]]
end

function M.close_all_but_current()
  vim.cmd [[BufferLineCloseLeft]]
  vim.cmd [[BufferLineCloseRight]]
end

-- Common kill function for bdelete and bwipeout
-- credits: based on bbye and nvim-bufdel
---@param kill_command string defaults to "bd"
---@param bufnr? number defaults to the current buffer
---@param force? boolean defaults to false
function M.close_buffer(kill_command, bufnr, force)
  local bo = vim.bo
  local api = vim.api

  if bufnr == 0 or bufnr == nil then
    bufnr = api.nvim_get_current_buf()
  end

  kill_command = kill_command or "bd"

  -- If buffer is modified and force isn't true, print error and abort
  if not force and bo[bufnr].modified then
    return api.nvim_err_writeln(
      string.format("No write since last change for buffer %d (set force to true to override)", bufnr)
    )
  end

  -- Get list of windows IDs with the buffer to close
  local windows = vim.tbl_filter(function(win)
    return api.nvim_win_get_buf(win) == bufnr
  end, api.nvim_list_wins())

  if #windows == 0 then
    return
  end

  if force then
    kill_command = kill_command .. "!"
  end

  -- Get list of active buffers
  local buffers = vim.tbl_filter(function(buf)
    return api.nvim_buf_is_valid(buf) and bo[buf].buflisted
  end, api.nvim_list_bufs())

  -- If there is only one buffer (which has to be the current one), vim will
  -- create a new buffer on :bd.
  -- For more than one buffer, pick the previous buffer (wrapping around if necessary)
  if #buffers > 1 then
    for i, v in ipairs(buffers) do
      if v == bufnr then
        local prev_buf_idx = i == 1 and (#buffers - 1) or (i - 1)
        local prev_buffer = buffers[prev_buf_idx]
        for _, win in ipairs(windows) do
          api.nvim_win_set_buf(win, prev_buffer)
        end
      end
    end
  end

  -- Check if buffer still exists, to ensure the target buffer wasn't killed
  -- due to options like bufhidden=wipe.
  if api.nvim_buf_is_valid(bufnr) and bo[bufnr].buflisted then
    vim.cmd(string.format("%s %d", kill_command, bufnr))
  end
end

function M.setup()
  local status_ok, bufferline = pcall(require, "bufferline")
  if not status_ok then
    return
  end

  bufferline.setup {
    options = {
      mode = "buffers",
      numbers = "ordinal",
      close_command = "bdelete! %d",
      indicator_icon = "▎",
      buffer_close_icon = "",
      modified_icon = "●",
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      max_name_length = 18,
      max_prefix_length = 15,
      tab_size = 18,
      diagnostics = false,
      diagnostics_update_in_insert = false,
      color_icons = true,
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = true,
      show_tab_indicators = true,
      persist_buffer_sort = true,
      separator_style = "thin",
      enforce_regular_tabs = false,
      always_show_bufferline = true,
    },
  }

  local utils = require "utils"

  utils.set_keymap("n", "<S-Left>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<S-Right>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })

  utils.set_keymap(
    "n",
    "<Leader>w",
    "<CMD>lua require('plugins.bufferline').close_buffer()<CR>",
    { noremap = true, silent = true }
  )
  utils.set_keymap(
    "n",
    "<Leader>x",
    "<CMD>lua require('plugins.bufferline').close_all_but_current()<CR>",
    { noremap = true, silent = true }
  )

  utils.set_keymap(
    "i",
    "<Leader>w",
    "<ESC>:lua require('plugins.bufferline').close_buffer()<CR>",
    { noremap = true, silent = true }
  )
  utils.set_keymap(
    "i",
    "<Leader>x",
    "<ESC>:lua require('plugins.bufferline').close_all_but_current()<CR>",
    { noremap = true, silent = true }
  )

  utils.set_keymap("n", "<Leader>1", ":BufferLineGoToBuffer 1<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Leader>2", ":BufferLineGoToBuffer 2<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Leader>3", ":BufferLineGoToBuffer 3<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Leader>4", ":BufferLineGoToBuffer 4<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Leader>5", ":BufferLineGoToBuffer 5<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Leader>6", ":BufferLineGoToBuffer 6<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Leader>7", ":BufferLineGoToBuffer 7<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Leader>8", ":BufferLineGoToBuffer 8<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Leader>9", ":BufferLineGoToBuffer 9<CR>", { noremap = true, silent = true })
  utils.set_keymap(
    "n",
    "<Leader>0",
    "<CMD>lua require('plugins.bufferline').go_to_last()<CR>",
    { noremap = true, silent = true }
  )

  utils.set_keymap("i", "<Leader>1", "<ESC>:BufferLineGoToBuffer 1<CR>", { noremap = true, silent = true })
  utils.set_keymap("i", "<Leader>2", "<ESC>:BufferLineGoToBuffer 2<CR>", { noremap = true, silent = true })
  utils.set_keymap("i", "<Leader>3", "<ESC>:BufferLineGoToBuffer 3<CR>", { noremap = true, silent = true })
  utils.set_keymap("i", "<Leader>4", "<ESC>:BufferLineGoToBuffer 4<CR>", { noremap = true, silent = true })
  utils.set_keymap("i", "<Leader>5", "<ESC>:BufferLineGoToBuffer 5<CR>", { noremap = true, silent = true })
  utils.set_keymap("i", "<Leader>6", "<ESC>:BufferLineGoToBuffer 6<CR>", { noremap = true, silent = true })
  utils.set_keymap("i", "<Leader>7", "<ESC>:BufferLineGoToBuffer 7<CR>", { noremap = true, silent = true })
  utils.set_keymap("i", "<Leader>8", "<ESC>:BufferLineGoToBuffer 8<CR>", { noremap = true, silent = true })
  utils.set_keymap("i", "<Leader>9", "<ESC>:BufferLineGoToBuffer 9<CR>", { noremap = true, silent = true })
  utils.set_keymap(
    "i",
    "<Leader>0",
    "<ESC>:lua require('plugins.bufferline').go_to_last()<CR>",
    { noremap = true, silent = true }
  )
end

return M

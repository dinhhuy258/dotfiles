local M = {}

local function augroup(name)
  return vim.api.nvim_create_augroup("dotfiles_" .. name, { clear = true })
end

function M.setup()
  -- Check if we need to reload the file when it changed
  vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup "checktime",
    command = "checktime",
  })

  -- Highlight on yank
  vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup "highlight_yank",
    callback = function()
      vim.highlight.on_yank { higroup = "Search", timeout = 200 }
    end,
  })

  -- Go to last loc when opening a buffer
  vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup "last_loc",
    callback = function()
      local exclude = { "gitcommit" }
      local buf = vim.api.nvim_get_current_buf()
      if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
        return
      end
      local mark = vim.api.nvim_buf_get_mark(buf, '"')
      local lcount = vim.api.nvim_buf_line_count(buf)
      if mark[1] > 0 and mark[1] <= lcount then
        pcall(vim.api.nvim_win_set_cursor, 0, mark)
      end
    end,
  })

  -- Close some filetypes with <q>
  vim.api.nvim_create_autocmd("FileType", {
    group = augroup "close_with_q",
    pattern = {
      "help",
      "lspinfo",
      "qf",
      "checkhealth",
      "AvanteInput",
    },
    callback = function(event)
      vim.bo[event.buf].buflisted = false
      vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
  })

  -- Wrap and check for spell in text filetypes
  vim.api.nvim_create_autocmd("FileType", {
    group = augroup "wrap_spell",
    pattern = { "gitcommit", "markdown" },
    callback = function()
      vim.opt_local.wrap = true
      vim.opt_local.spell = true
    end,
  })

  -- Set nobuflisted for some filetypes
  vim.api.nvim_create_autocmd("FileType", {
    group = augroup "_filetype_nobuflisted",
    pattern = {
      "qf",
      "dap-repl", -- nvim-dap
    },
    callback = function()
      vim.bo.buflisted = false
    end,
  })
end

return M

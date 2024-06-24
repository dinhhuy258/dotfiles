local keymaps = require "config.keymaps"
local icons = require "icons"

local M = {}

M.setup = function()
  local status_ok, gitsigns = pcall(require, "gitsigns")
  if not status_ok then
    return
  end

  gitsigns.setup {
    signs = {
      add = {
        text = icons.gitsigns.add,
      },
      change = {
        text = icons.gitsigns.change,
      },
      delete = {
        text = icons.gitsigns.delete,
      },
      topdelete = {
        text = icons.gitsigns.topdelete,
      },
      changedelete = {
        text = icons.gitsigns.changedelete,
      },
      untracked = {
        text = icons.gitsigns.untracked,
      },
    },
    numhl = false,
    linehl = false,
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr

        keymaps.set(mode, l, r, opts)
      end

      -- navigation
      map("n", "ghn", function()
        if vim.wo.diff then
          return "ghn"
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })

      map("n", "ghN", function()
        if vim.wo.diff then
          return "ghN"
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })

      map("n", "ghv", gs.preview_hunk)
      map("n", "ghu", gs.reset_hunk)
      map("v", "ghu", function()
        gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
      end)
      map("n", "ghU", gs.reset_buffer)

      map("n", "ghs", gs.stage_hunk)
      map("v", "ghs", function()
        gs.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
      end)
      map("n", "ghS", gs.stage_buffer)

      map("n", "ghl", function()
        gs.blame_line { full = false }
      end)

      map("n", "ghd", gs.diffthis)
      map("n", "ghD", function()
        gs.diffthis "~"
      end)
    end,
    signcolumn = true,
    word_diff = false,
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
    },
    max_file_length = 40000,
    preview_config = {
      -- Options passed to nvim_open_win
      border = "rounded",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    sign_priority = 6,
    update_debounce = 200,
    status_formatter = nil, -- Use default
  }
end

return M

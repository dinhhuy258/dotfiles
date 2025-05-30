local keymaps = require "config.keymaps"
local icons = require "icons"

local M = {}

M.setup = function()
  keymaps.set("n", "<Leader>[", ":BufferPrevious<CR>", { noremap = true, silent = true })
  keymaps.set("n", "<Leader>]", ":BufferNext<CR>", { noremap = true, silent = true })

  keymaps.set("n", "<Leader>1", ":BufferGoto 1<CR>", { noremap = true, silent = true })
  keymaps.set("n", "<Leader>2", ":BufferGoto 2<CR>", { noremap = true, silent = true })
  keymaps.set("n", "<Leader>3", ":BufferGoto 3<CR>", { noremap = true, silent = true })
  keymaps.set("n", "<Leader>4", ":BufferGoto 4<CR>", { noremap = true, silent = true })
  keymaps.set("n", "<Leader>5", ":BufferGoto 5<CR>", { noremap = true, silent = true })
  keymaps.set("n", "<Leader>6", ":BufferGoto 6<CR>", { noremap = true, silent = true })
  keymaps.set("n", "<Leader>7", ":BufferGoto 7<CR>", { noremap = true, silent = true })
  keymaps.set("n", "<Leader>8", ":BufferGoto 8<CR>", { noremap = true, silent = true })
  keymaps.set("n", "<Leader>9", ":BufferGoto 9<CR>", { noremap = true, silent = true })
  keymaps.set("n", "<Leader>0", ":BufferLast<CR>", { noremap = true, silent = true })

  keymaps.set("n", "<Leader>w", ":BufferClose<CR>", { noremap = true, silent = true })
  keymaps.set("n", "<Leader>x", ":BufferCloseAllButCurrent<CR>", { noremap = true, silent = true })

  keymaps.set("n", "<Leader>bb", ":BufferPin<CR>", { noremap = true, silent = true })

  -- Set barbar's options
  require("barbar").setup {
    -- Enable/disable animations
    animation = false,

    -- Enable/disable auto-hiding the tab bar when there is a single buffer
    auto_hide = false,

    -- Enable/disable current/total tabpages indicator (top right corner)
    tabpages = true,

    -- Enables/disable clickable tabs
    --  - left-click: go to buffer
    --  - middle-click: delete buffer
    clickable = false,

    -- Excludes buffers from the tabline
    exclude_ft = {},
    exclude_name = {},

    -- -- A buffer to this direction will be focused (if it exists) when closing the current buffer.
    -- -- Valid options are 'left' (the default) and 'right'
    focus_on_close = "left",

    -- -- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
    -- hide = { extensions = true, inactive = true },

    -- Disable highlighting alternate buffers
    highlight_alternate = false,

    -- Disable highlighting file icons in inactive buffers
    highlight_inactive_file_icons = false,

    -- Enable highlighting visible buffers
    highlight_visible = false,

    icons = {
      -- Configure the base icons on the bufferline.
      buffer_index = true,
      buffer_number = false,
      button = icons.barbar.active_button,
      -- Enables / disables diagnostic symbols
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = false },
        [vim.diagnostic.severity.WARN] = { enabled = false },
        [vim.diagnostic.severity.INFO] = { enabled = false },
        [vim.diagnostic.severity.HINT] = { enabled = false },
      },
      filetype = {
        -- Sets the icon's highlight group.
        -- If false, will use nvim-web-devicons colors
        custom_colors = false,

        -- Requires `nvim-web-devicons` if `true`
        enabled = true,
      },
      separator = { left = icons.barbar.separator_left, right = "" },

      -- Configure the icons on the bufferline when modified or pinned.
      -- Supports all the base icon options.
      modified = { button = icons.barbar.modified_button },
      pinned = { button = icons.barbar.pinned_button },

      -- Configure the icons on the bufferline based on the visibility of a buffer.
      -- Supports all the base icon options, plus `modified` and `pinned`.
      alternate = { filetype = { enabled = false } },
      current = { buffer_index = true },
      inactive = { button = icons.barbar.inactive_button },
      visible = { modified = { buffer_number = false } },
    },

    -- If true, new buffers will be inserted at the start/end of the list.
    -- Default is to insert after current buffer.
    insert_at_end = false,
    insert_at_start = false,

    -- Sets the maximum padding width with which to surround each tab
    maximum_padding = 1,

    -- Sets the minimum padding width with which to surround each tab
    minimum_padding = 1,

    -- Sets the maximum buffer name length.
    maximum_length = 30,

    -- If set, the letters for each buffer in buffer-pick mode will be
    -- assigned based on their name. Otherwise or in case all letters are
    -- already assigned, the behavior is to assign letters in order of
    -- usability (see order below)
    semantic_letters = true,

    -- Set the filetypes which barbar will offset itself for
    sidebar_filetypes = {
      -- Use the default values: {event = 'BufWinLeave', text = nil}
      NvimTree = true,
      -- Or, specify the text used for the offset:
      undotree = { text = "undotree" },
      -- Or, specify the event which the sidebar executes when leaving:
      ["neo-tree"] = { event = "BufWipeout" },
      -- Or, specify both
      Outline = { event = "BufWinLeave", text = "symbols-outline" },
    },

    -- New buffer letters are assigned in this order. This order is
    -- optimal for the qwerty keyboard layout but might need adjustement
    -- for other layouts.
    letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",

    -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
    -- where X is the buffer number. But only a static string is accepted here.
    no_name_title = nil,
  }
end

return M

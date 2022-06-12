local M = {}

M.setup = function()
  local utils = require "utils"

  utils.set_keymap("n", "<S-Left>", ":BufferPrevious<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<S-Right>", ":BufferNext<CR>", { noremap = true, silent = true })

  utils.set_keymap("n", "<Leader>[", ":BufferMovePrevious<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Leader>]", ":BufferMoveNext<CR>", { noremap = true, silent = true })

  utils.set_keymap("n", "<Leader>1", ":BufferGoto 1<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Leader>2", ":BufferGoto 2<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Leader>3", ":BufferGoto 3<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Leader>4", ":BufferGoto 4<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Leader>5", ":BufferGoto 5<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Leader>6", ":BufferGoto 6<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Leader>7", ":BufferGoto 7<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Leader>8", ":BufferGoto 8<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Leader>9", ":BufferGoto 9<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Leader>0", ":BufferLast<CR>", { noremap = true, silent = true })

  utils.set_keymap("i", "<Leader>1", "<ESC>:BufferGoto 1<CR>", { noremap = true, silent = true })
  utils.set_keymap("i", "<Leader>2", "<ESC>:BufferGoto 2<CR>", { noremap = true, silent = true })
  utils.set_keymap("i", "<Leader>3", "<ESC>:BufferGoto 3<CR>", { noremap = true, silent = true })
  utils.set_keymap("i", "<Leader>4", "<ESC>:BufferGoto 4<CR>", { noremap = true, silent = true })
  utils.set_keymap("i", "<Leader>5", "<ESC>:BufferGoto 5<CR>", { noremap = true, silent = true })
  utils.set_keymap("i", "<Leader>6", "<ESC>:BufferGoto 6<CR>", { noremap = true, silent = true })
  utils.set_keymap("i", "<Leader>7", "<ESC>:BufferGoto 7<CR>", { noremap = true, silent = true })
  utils.set_keymap("i", "<Leader>8", "<ESC>:BufferGoto 8<CR>", { noremap = true, silent = true })
  utils.set_keymap("i", "<Leader>9", "<ESC>:BufferGoto 9<CR>", { noremap = true, silent = true })
  utils.set_keymap("i", "<Leader>0", "<ESC>:BufferLast<CR>", { noremap = true, silent = true })

  utils.set_keymap("n", "<Leader>w", ":BufferClose<CR>", { noremap = true, silent = true })
  utils.set_keymap("n", "<Leader>x", ":BufferCloseAllButCurrent<CR>", { noremap = true, silent = true })

  utils.set_keymap("i", "<Leader>w", "<ESC>:BufferClose<CR>", { noremap = true, silent = true })
  utils.set_keymap("i", "<Leader>x", "<ESC>:BufferCloseAllButCurrent<CR>", { noremap = true, silent = true })

  utils.set_keymap("n", "<Leader>bb", ":BufferPin<CR>", { noremap = true, silent = true })

  -- Set barbar's options
  vim.g.bufferline = {
    -- Enable/disable animations
    animation = false,

    -- Enable/disable auto-hiding the tab bar when there is a single buffer
    auto_hide = false,

    -- Enable/disable current/total tabpages indicator (top right corner)
    tabpages = true,

    -- Enable/disable close button
    closable = true,

    -- Enables/disable clickable tabs
    --  - left-click: go to buffer
    --  - middle-click: delete buffer
    clickable = true,

    -- Excludes buffers from the tabline
    exclude_ft = {},
    exclude_name = {},

    -- Enable/disable icons
    -- if set to 'numbers', will show buffer index in the tabline
    -- if set to 'both', will show buffer index and icons in the tabline
    icons = "numbers",

    -- If set, the icon color will follow its corresponding buffer
    -- highlight group. By default, the Buffer*Icon group is linked to the
    -- Buffer* group (see Highlighting below). Otherwise, it will take its
    -- default value as defined by devicons.
    icon_custom_colors = false,

    -- Configure icons on the bufferline.
    icon_separator_active = "▎",
    icon_separator_inactive = "▎",
    icon_close_tab = "",
    icon_close_tab_modified = "●",
    icon_pinned = "車",

    -- Sets the maximum padding width with which to surround each tab
    maximum_padding = 1,

    -- Sets the maximum buffer name length.
    maximum_length = 50,

    -- If set, the letters for each buffer in buffer-pick mode will be
    -- assigned based on their name. Otherwise or in case all letters are
    -- already assigned, the behavior is to assign letters in order of
    -- usability (see order below)
    semantic_letters = true,

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

local utils = require "utils"
local M = {}

M.setup = function()
  local status_ok, compe = pcall(require, "compe")
  if not status_ok then
    return
  end

  -- Suggestion from nvim-compe
  vim.o.completeopt = "menuone,noselect"

  compe.setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = "enable",
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = {
      border = "single",
      winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    },
    -- documentation = true,

    source = {
      path = { kind = "   (Path)" },
      buffer = { kind = "   (Buffer)" },
      calc = { kind = "   (Calc)" },
      vsnip = { kind = "   (Snippet)" },
      nvim_lsp = { kind = "   (LSP)" },
      nvim_lua = false,
      spell = { kind = "   (Spell)" },
      tags = false,
      vim_dadbod_completion = false,
      snippets_nvim = false,
      ultisnips = false,
      treesitter = false,
      emoji = { kind = " ﲃ  (Emoji)", filetypes = { "markdown", "text" } },
      -- for emoji press : (idk if that in compe tho)
    },
  }

  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end

  local check_back_space = function()
    local col = vim.fn.col "." - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match "%s" then
      return true
    else
      return false
    end
  end

  vim.api.nvim_set_keymap(
    "i",
    "<Tab>",
    'pumvisible() ? "<C-n>" : "<Tab>"',
    { silent = true, noremap = true, expr = true }
  )

  vim.api.nvim_set_keymap(
    "i",
    "<S-Tab>",
    'pumvisible() ? "<C-p>" : "<S-Tab>"',
    { silent = true, noremap = true, expr = true }
  )

  -- Use (s-)tab to:
  --- move to prev/next item in completion menuone
  --- jump to prev/next snippet's placeholder
  _G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
      return t "<C-n>"
    elseif vim.fn.call("vsnip#available", { 1 }) == 1 then
      return t "<Plug>(vsnip-expand-or-jump)"
    elseif check_back_space() then
      return t "<Tab>"
    else
      return vim.fn["compe#complete"]()
    end
  end

  _G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
      return t "<C-p>"
    elseif vim.fn.call("vsnip#jumpable", { -1 }) == 1 then
      return t "<Plug>(vsnip-jump-prev)"
    else
      return t "<S-Tab>"
    end
  end

  utils.set_keymap("i", "<C-Space>", "compe#complete()", { noremap = true, silent = true, expr = true })
  -- utils.set_keymap("i", "<CR>", "compe#confirm('<CR>')", { noremap = true, silent = true, expr = true })
  utils.set_keymap("i", "<C-e>", "compe#close('<C-e>')", { noremap = true, silent = true, expr = true })
  utils.set_keymap("i", "<C-f>", "compe#scroll({ 'delta': +4 })", { noremap = true, silent = true, expr = true })
  utils.set_keymap("i", "<C-d>", "compe#scroll({ 'delta': -4 })", { noremap = true, silent = true, expr = true })
end

return M

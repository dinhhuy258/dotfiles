local icons = require "icons"

local M = {}

M.setup = function()
  local blink_cmp_ok, blink_cmp = pcall(require, "blink.cmp")
  if not blink_cmp_ok then
    return
  end

  blink_cmp.setup({
    -- Use 'super-tab' for mappings similar to your current nvim-cmp setup
    keymap = { preset = 'super-tab' },

    appearance = {
      -- Use 'mono' for 'Nerd Font Mono' to ensure proper icon alignment
      nerd_font_variant = 'mono'
    },

    -- Configure completion behavior
    completion = {
      -- Enable auto brackets (important for nvim-autopairs compatibility)
      accept = { auto_brackets = { enabled = true } },

      -- Configure list behavior similar to your nvim-cmp setup
      list = {
        selection = {
          preselect = true,
          auto_insert = true,
        },
      },

      -- Configure menu appearance to match nvim-cmp style
      menu = {
        auto_show = true,
        draw = {
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "kind" }
          },
        }
      },

      -- Enable documentation popup
      documentation = { auto_show = true, auto_show_delay_ms = 500 },

      -- Enable ghost text preview
      ghost_text = { enabled = true },
    },

    -- Configure cmdline completion
    cmdline = {
      enabled = true,
      keymap = { preset = 'cmdline' },
      sources = { 'buffer', 'cmdline' },
      completion = {
        list = {
          selection = {
            preselect = true,
            auto_insert = true,
          },
        },
        menu = { auto_show = false },
        ghost_text = { enabled = true },
      }
    },

    -- Configure sources (equivalent to your nvim-cmp sources)
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        lsp = {
          name = 'LSP',
          fallbacks = { 'buffer' },
          -- Filter text items since we have buffer provider
          transform_items = function(_, items)
            return vim.tbl_filter(
              function(item) return item.kind ~= require('blink.cmp.types').CompletionItemKind.Text end,
              items
            )
          end,
        },
        
        path = {
          score_offset = 3,
          fallbacks = { 'buffer' },
        },

        snippets = {
          score_offset = -1,
        },

        buffer = {
          score_offset = -3,
        },
      }
    },

    -- Use LuaSnip preset to maintain compatibility with your existing snippets
    snippets = { preset = 'luasnip' },

    -- Enable signature help
    signature = { enabled = true },

    -- Configure fuzzy matching
    fuzzy = { implementation = "prefer_rust_with_warning" }
  })
end

return M
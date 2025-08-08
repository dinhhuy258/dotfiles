local icons = require "icons"

local M = {}

M.setup = function()
  local blink_cmp_ok, blink_cmp = pcall(require, "blink.cmp")
  if not blink_cmp_ok then
    return
  end

  -- load VS Code style snippets from a plugin rafamadriz/friendly-snippets
  require("luasnip.loaders.from_vscode").lazy_load()

  blink_cmp.setup {
    keymap = {
      preset = "super-tab",
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
    },

    appearance = {
      nerd_font_variant = "normal",
      kind_icons = icons.lsp,
    },

    completion = {
      keyword = {
        range = "prefix",
      },

      list = {
        selection = {
          preselect = true,
          auto_insert = true,
        },
      },

      accept = {
        auto_brackets = { enabled = true },
      },

      menu = {
        auto_show = true,
        draw = {
          columns = {
            { "label",     "label_description", gap = 1 },
            { "kind_icon", "kind" },
          },
        },
      },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
      },
    },

    cmdline = {
      enabled = true,
      keymap = { preset = "cmdline" },
      sources = { "buffer", "cmdline" },
      completion = {
        list = {
          selection = {
            preselect = true,
            auto_insert = true,
          },
        },
        menu = { auto_show = true },
        ghost_text = { enabled = true },
      },
    },

    snippets = { preset = "luasnip" },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  }
end

return M

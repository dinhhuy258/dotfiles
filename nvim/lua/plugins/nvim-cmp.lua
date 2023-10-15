local icons = require "icons"

local M = {}

M.setup = function()
  local cmp_ok, cmp = pcall(require, "cmp")
  if not cmp_ok then
    return
  end

  local luasnip_ok, luasnip = pcall(require, "luasnip")
  if not luasnip_ok then
    return
  end

  -- load VS Code style snippets from a plugin rafamadriz/friendly-snippets
  require("luasnip.loaders.from_vscode").lazy_load()

  local _, types = pcall(require, "cmp.types")
  local _, compare = pcall(require, "cmp.config.compare")

  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
  end

  cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })

  local source_names = {
    luasnip = "(Snippet)",
    nvim_lsp = "(LSP)",
    buffer = "(Buffer)",
    path = "(Path)",
  }

  cmp.setup {
    completion = {
      autocomplete = {
        types.cmp.TriggerEvent.TextChanged,
      },
      keyword_length = 1,
    },
    formatting = {
      format = function(entry, item)
        item.menu = source_names[entry.source.name] or string.format("[%s]", entry.source.name)
        item.kind = string.format("%s %s", icons.kind[item.kind], item.kind)

        return item
      end,
    },
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    sorting = {
      priority_weight = 2,
      comparators = {
        compare.offset,
        compare.exact,
        compare.score,
        compare.kind,
        compare.sort_text,
        compare.length,
        compare.order,
      },
    },
    confirmation = {
      default_behavior = types.cmp.ConfirmBehavior.Insert,
    },
    mapping = {
      ["<up>"] = cmp.mapping.select_prev_item(),
      ["<down>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<CR>"] = cmp.mapping.confirm { select = true },
      ["<C-c>"] = cmp.mapping.close(),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
    },
    sources = {
      { name = "luasnip" },
      { name = "nvim_lsp" },
      { name = "buffer" },
      { name = "path" },
    },
  }
end

return M

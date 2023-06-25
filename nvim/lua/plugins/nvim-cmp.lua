local M = {}

M.setup = function()
  local status_ok, cmp = pcall(require, "cmp")
  if not status_ok then
    return
  end

  local _, types = pcall(require, "cmp.types")
  local _, compare = pcall(require, "cmp.config.compare")

  local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  end

  local has_words_before = function()
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

  local kind_icons = {
    Array = "",
    Boolean = "",
    Class = "",
    Color = "",
    Constant = "",
    Constructor = "",
    Enum = "",
    EnumMember = "",
    Event = "",
    Field = "",
    File = "",
    Folder = "󰉋",
    Function = "",
    Interface = "",
    Key = "",
    Keyword = "",
    Method = "",
    Module = "",
    Namespace = "",
    Null = "󰟢",
    Number = "",
    Object = "",
    Operator = "",
    Package = "",
    Property = "",
    Reference = "",
    Snippet = "",
    String = "",
    Struct = "",
    Text = "",
    TypeParameter = "",
    Unit = "",
    Value = "",
    Variable = "",
  }

  local source_names = {
    vsnip = "(Snippet)",
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
        item.kind = string.format("%s %s", kind_icons[item.kind], item.kind)

        return item
      end,
    },
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
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
        elseif vim.fn["vsnip#available"](1) == 1 then
          feedkey("<Plug>(vsnip-expand-or-jump)", "")
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
          -- return t "<Tab>"
        end
      end, {
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(_)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
          feedkey("<Plug>(vsnip-jump-prev)", "")
        end
      end, {
        "i",
        "s",
      }),
    },
    sources = {
      { name = "vsnip" },
      { name = "nvim_lsp" },
      { name = "buffer" },
      { name = "path" },
    },
  }
end

return M

local M = {}

M.setup = function()
  local status_ok, cmp = pcall(require, "cmp")
  if not status_ok then
    return
  end

  local _, types = pcall(require, "cmp.types")
  local _, compare = pcall(require, "cmp.config.compare")
  local _, keymap = pcall(require, "cmp.utils.keymap")

  local check_back_space = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
  end

  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end

  cmp.setup {
    completion = {
      autocomplete = {
        types.cmp.TriggerEvent.TextChanged,
      },
      keyword_length = 1,
    },
    formatting = {
      format = function(entry, vim_item)
        vim_item.menu = ({
          vsnip = "[Vsnip]",
          nvim_lsp = "[LSP]",
          buffer = "[Buffer]",
          path = "[Path]",
        })[entry.source.name]
        return vim_item
      end,
    },
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    preselect = cmp.PreselectMode.Item,
    documentation = {
      type = cmp.DocumentationConfig,
      border = "single",
      winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
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
      ['<C-c>'] = cmp.mapping.close(),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<Tab>"] = cmp.mapping(function(_)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(t "<C-n>", "n")
        elseif vim.fn["vsnip#jumpable"](1) == 1 then
          vim.fn.feedkeys(keymap.t "<Plug>(vsnip-jump-next)", "")
        elseif check_back_space() then
          vim.fn.feedkeys(t "<Tab>", "n")
        else
          return t "<Tab>"
        end
      end, {
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(_)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(t "<C-p>", "n")
        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
          vim.fn.feedkeys(keymap.t "<Plug>(vsnip-jump-prev)", "")
        else
          return t "<S-Tab>"
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

  for index, value in ipairs(vim.lsp.protocol.CompletionItemKind) do
    cmp.lsp.CompletionItemKind[index] = value
  end
end

return M

local M = {}

local blink = require "blink.cmp"
local icons = require "icons"
local lsp_keymaps = require "lsp.keymaps"
local lsp_signature = require "lsp_signature"
local navbuddy = require "nvim-navbuddy"

function M.setup_global_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend("force", capabilities, blink.get_lsp_capabilities())

  vim.lsp.config("*", {
    capabilities = capabilities,
    root_markers = { ".git", ".hg" },
  })
end

function M.setup_handlers()
  vim.diagnostic.config {
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = icons.diagnostics.error,
        [vim.diagnostic.severity.WARN] = icons.diagnostics.warning,
        [vim.diagnostic.severity.INFO] = icons.diagnostics.info,
        [vim.diagnostic.severity.HINT] = icons.diagnostics.hint,
      },
    },
    virtual_text = true,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = true,
      header = "",
      prefix = "",
    },
  }
end

function M.setup_servers()
  local servers = {
    "clangd",
    "ts_ls",
    "jsonls",
    "lua_ls",
    "phpactor",
    "ruby_lsp",
    "basedpyright",
    "sqlls",
    "yamlls",
    "gopls",
    "bashls",
    "terraformls",
    "buf_ls",
  }

  for _, server in ipairs(servers) do
    local ok, server_config = pcall(require, "lsp.settings." .. server)
    if ok then
      vim.lsp.config(server, server_config)
    end

    vim.lsp.enable(server)
  end
end

function M.setup_autocmds()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if not client then
        return
      end

      local bufnr = args.buf

      lsp_keymaps.setup(bufnr)

      -- Setup lsp_signature
      lsp_signature.on_attach({
        hint_enable = false,
        hi_parameter = "Underlined",
      }, bufnr)

      -- Setup nvim-navbuddy (only for clients that support document symbols)
      if client:supports_method "textDocument/documentSymbol" then
        navbuddy.attach(client, bufnr)
      end
    end,
  })

  -- Setup LspDetach autocmd for cleanup
  vim.api.nvim_create_autocmd("LspDetach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = false }),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      -- Clean up formatting autocmd if it exists
      if client and client:supports_method "textDocument/formatting" then
        vim.api.nvim_clear_autocmds {
          group = "LspFormatting",
          buffer = args.buf,
        }
      end
    end,
  })
end

function M.setup()
  M.setup_global_config()
  M.setup_handlers()
  M.setup_servers()
  M.setup_autocmds()
end

return M

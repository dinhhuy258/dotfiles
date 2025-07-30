local M = {}

local cmp_nvim_lsp = require "cmp_nvim_lsp"
local icons = require "icons"
local lsp_keymaps = require "lsp.keymaps"
local lsp_signature = require "lsp_signature"
local navbuddy = require "nvim-navbuddy"

-- Configure global LSP settings for all servers
function M.setup_global_config()
  -- Set global capabilities and settings that apply to all LSP clients
  vim.lsp.config("*", {
    capabilities = vim.tbl_deep_extend(
      "force",
      vim.lsp.protocol.make_client_capabilities(),
      cmp_nvim_lsp.default_capabilities()
    ),
    root_markers = { ".git", ".hg" },
  })
end

-- Setup LSP handlers and diagnostics
function M.setup_handlers()
  -- Configure diagnostics
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
      source = "always",
      header = "",
      prefix = "",
    },
  }

  -- Configure LSP handlers with rounded borders
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

-- Configure individual servers
function M.setup_servers()
  -- Load server-specific configurations
  local servers = {
    "clangd",
    "ts_ls",
    "jsonls",
    "lua_ls",
    "phpactor",
    "basedpyright",
    "sqlls",
    "yamlls",
    "gopls",
    "bashls",
    "terraformls",
    "buf_ls",
  }

  for _, server in ipairs(servers) do
    -- Try to load server-specific settings
    local ok, server_config = pcall(require, "lsp.settings." .. server)
    if ok then
      vim.lsp.config(server, server_config)
    end

    -- Enable the server
    vim.lsp.enable(server)
  end
end

-- Setup LspAttach autocmd for buffer-local configuration
function M.setup_autocmds()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      local bufnr = args.buf

      -- Setup keymaps
      lsp_keymaps.setup(bufnr)

      -- Disable formatting for Go files (handled by go.nvim)
      if vim.bo[bufnr].filetype == "go" then
        client.server_capabilities.documentFormattingProvider = false
      end

      -- Setup lsp_signature
      lsp_signature.on_attach({
        hint_enable = false,
        hi_parameter = "Underlined",
      }, bufnr)

      -- Setup nvim-navbuddy (only for clients that support document symbols)
      if client:supports_method "textDocument/documentSymbol" then
        navbuddy.attach(client, bufnr)
      end

      -- Enable completion if supported
      if client:supports_method "textDocument/completion" then
        vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
      end

      -- Auto-format on save for supported servers
      if
          client:supports_method "textDocument/formatting"
          and not client:supports_method "textDocument/willSaveWaitUntil"
      then
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("LspFormatting", { clear = false }),
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format {
              bufnr = bufnr,
              id = client.id,
              timeout_ms = 1000,
            }
          end,
        })
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

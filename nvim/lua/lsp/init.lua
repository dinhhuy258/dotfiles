-- Modern LSP setup for Neovim 0.11+
local M = {}

function M.setup()
  -- Set global LSP configuration for all servers
  vim.lsp.config('*', {
    capabilities = {
      textDocument = {
        completion = {
          completionItem = {
            snippetSupport = true,
            preselectSupport = true,
            insertReplaceSupport = true,
            labelDetailsSupport = true,
            deprecatedSupport = true,
            commitCharactersSupport = true,
            documentationFormat = { "markdown", "plaintext" },
            resolveSupport = {
              properties = { "documentation", "detail", "additionalTextEdits" },
            },
          },
        },
        foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        },
        semanticTokens = {
          multilineTokenSupport = true,
        },
      },
      workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      },
    },
    root_markers = { '.git' },
  })

  -- Load LSP modules
  require('lsp.diagnostics').setup()
  require('lsp.keymaps').setup()
  require('lsp.autocmds').setup()
  
  -- Enable specific LSP servers
  -- Each server config is defined in lsp/<server_name>.lua
  vim.lsp.enable({
    "lua_ls",
    "gopls", 
    "basedpyright",
    "ts_ls",
    "jsonls",
    "yamlls",
    "clangd",
    "phpactor",
    "sqlls",
    "bashls",
    "terraformls",
    "buf_ls",
  })
end

return M

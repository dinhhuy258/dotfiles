local M = {}

function M.config(common_on_attach, common_capabilities, common_on_init)
  lsp_clients["lua"] = {
    lsp = {
      provider = "sumneko_lua",
      setup = {
        capabilities = common_capabilities,
        on_attach = common_on_attach,
        on_init = common_on_init,
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = "LuaJIT",
              -- Setup your lua path
              path = vim.split(package.path, ";"),
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim", "lsp_clients" },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = {
                [vim.fn.expand "~/.config/nvim/lua"] = true,
                [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
              },
              maxPreload = 100000,
              preloadFileSize = 1000,
            },
          },
        },
      },
    },
  }
end

return M

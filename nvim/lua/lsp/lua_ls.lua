-- Lua Language Server configuration
return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          "${3rd}/luv/library",
          "${3rd}/busted/library",
        },
      },
      completion = { callSnippet = "Replace" },
      telemetry = { enable = false },
      hint = { enable = true },
      diagnostics = {
        globals = { 'vim', 'reload' },
      },
    },
  },
}
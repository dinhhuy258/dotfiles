-- Modern lua_ls configuration for vim.lsp.config()
return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
  settings = {
    Lua = {
      telemetry = { enable = false },
      runtime = {
        version = "LuaJIT",
        special = {
          reload = "require",
        },
      },
      diagnostics = {
        globals = { "vim", "reload" },
      },
      workspace = {
        library = {
          vim.fn.expand("$VIMRUNTIME"),
          "${3rd}/busted/library",
          "${3rd}/luassert/library", 
          "${3rd}/luv/library",
        },
        maxPreload = 5000,
        preloadFileSize = 10000,
        checkThirdParty = false,
      },
      completion = {
        callSnippet = "Replace",
      },
      hint = { 
        enable = true,
        setType = false,
        paramType = true,
        paramName = "Disable",
        semicolon = "Disable",
        arrayIndex = "Disable",
      },
    },
  },
}

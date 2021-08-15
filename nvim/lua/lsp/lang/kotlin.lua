local M = {}

function M.config(common_on_attach, common_capabilities, common_on_init)
  lsp_clients["kotlin"] = {
    formatters = {},
    linters = {},
    lsp = {
      provider = "kotlin_language_server",
      setup = {
        cmd = { "nc", "localhost", "6969" },
        root_dir = function(fname)
          local util = require "lspconfig/util"

          local root_files = {
            "settings.gradle", -- Gradle (multi-project)
            "settings.gradle.kts", -- Gradle (multi-project)
            "build.xml", -- Ant
            "pom.xml", -- Maven
          }

          local fallback_root_files = {
            "build.gradle", -- Gradle
            "build.gradle.kts", -- Gradle
          }
          return util.root_pattern(unpack(root_files))(fname) or util.root_pattern(unpack(fallback_root_files))(fname)
        end,
        filetypes = { "kotlin" },
        autostart = false,
        on_attach = common_on_attach,
        on_init = common_on_init,
        capabilities = common_capabilities,
      },
    },
  }
end

return M

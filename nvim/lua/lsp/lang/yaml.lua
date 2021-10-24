local M = {}

function M.config(common_on_attach, common_capabilities, common_on_init)
  lsp_clients["yaml"] = {
    lsp = {
      provider = "yamlls",
      setup = {
        on_attach = common_on_attach,
        on_init = common_on_init,
        capabilities = common_capabilities,
        filetypes = { "yaml", "yml" },
        settings = {
          yaml = {
            validate = true,
            format = {
              enable = true,
              singleQuote = false,
              bracketSpacing = true,
            },
            editor = {
              tabSize = 2,
            },
            schemaStore = {
              enable = true,
              url = "https://www.schemastore.org/api/json/catalog.json",
            },
            schemas = {
              kubernetes = {
                "daemon.yaml",
                "manager.yaml",
                "restapi.yaml",
                "role.yaml",
                "role_binding.yaml",
                "*onfigma*.yaml",
                "*ngres*.yaml",
                "*ecre*.yaml",
                "*eployment*.yaml",
                "*ervic*yaml",
                "kubectl-edit*.yaml",
              },
            },
          },
        },
      },
    },
  }
end

return M

-- YAML Language Server configuration
return {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml', 'yml' },
  root_markers = { '.git' },
  settings = {
    yaml = {
      schemas = require('schemastore').yaml.schemas(),
      validate = true,
      format = { enable = true },
      hover = true,
      completion = true,
    },
  },
}
return {
  settings = {
    yaml = {
      hover = true,
      completion = true,
      validate = true,
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
      schemas = require("schemastore").yaml.schemas(),
      customTags = {
        -- AWS CloudFormation
        "!fn",
        "!And",
        "!If",
        "!Not",
        "!Equals",
        "!Or",
        "!FindInMap sequence",
        "!Base64",
        "!Cidr",
        "!Ref",
        "!Ref Scalar",
        "!Sub",
        "!GetAtt",
        "!GetAZs",
        "!ImportValue",
        "!Select",
        "!Split",
        "!Join sequence",
      },
    },
  },
}

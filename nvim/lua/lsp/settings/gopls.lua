return {
  settings = {
    gopls = {
      analyses = {
        unusedvariable = true,
        unusedparams = true,
        unusedwrite = true,
      },
      staticcheck = true,
      completeUnimported = true,
      usePlaceholders = true,
    },
  },
}

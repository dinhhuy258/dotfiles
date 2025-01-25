return {
  settings = {
    basedpyright = {
      analysis = {
        diagnosticSeverityOverrides = {
          reportUnknownArgumentType = false,
          reportUnknownMemberType = false,
          reportUnknownVariableType = false,
          reportUnknownParameterType = false,
          reportMissingParameterType = false,
          reportMissingTypeArgument = false,
          reportMissingTypeStubs = false,
        },
      },
    },
  },
}

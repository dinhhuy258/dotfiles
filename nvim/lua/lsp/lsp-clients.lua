local M = {}

function M.setup(common_on_attach, capabilities, common_on_init)
  require("lsp.lang.go").config(common_on_attach, capabilities, common_on_init)
  require("lsp.lang.lua").config(common_on_attach, capabilities, common_on_init)
  require("lsp.lang.json").config(common_on_attach, capabilities, common_on_init)
  require("lsp.lang.php").config(common_on_attach, capabilities, common_on_init)
  require("lsp.lang.sql").config(common_on_attach, capabilities, common_on_init)
  require("lsp.lang.cpp").config(common_on_attach, capabilities, common_on_init)
  require("lsp.lang.javascript").config(common_on_attach, capabilities, common_on_init)
  require("lsp.lang.python").config(common_on_attach, capabilities, common_on_init)
end

return M

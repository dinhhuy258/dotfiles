local M = {}

M.setup = function()
  require("nvim-treesitter.configs").setup {
    autotag = {
      enable = true,
    },
  }
end

return M

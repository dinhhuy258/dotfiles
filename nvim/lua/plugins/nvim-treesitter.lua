local M = {}

M.setup = function()
  local status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
  if not status_ok then
    return
  end

  treesitter_configs.setup {
    ensure_installed = "maintained",
    highlight = {
      enable = true,
      disable = { "kotlin" },
    },
    indent = {
      enable = true,
    },
  }
end

return M

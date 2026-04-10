local M = {}

M.setup = function()
  local ok, ts = pcall(require, "nvim-treesitter")
  if not ok then
    return
  end

  ts.install {
    "bash",
    "c",
    "cpp",
    "css",
    "dockerfile",
    "go",
    "html",
    "java",
    "javascript",
    "json",
    "kotlin",
    "lua",
    "markdown",
    "php",
    "python",
    "ruby",
    "rust",
    "sql",
    "swift",
    "toml",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
  }

  vim.api.nvim_create_autocmd("FileType", {
    callback = function()
      if vim.treesitter.get_parser(0, nil, { error = false }) then
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end,
  })
end

return M

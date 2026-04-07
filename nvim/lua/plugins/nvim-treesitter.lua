local M = {}

M.setup = function()
  vim.api.nvim_create_autocmd("FileType", {
    callback = function()
      if vim.treesitter.get_parser(0, nil, { error = false }) then
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end,
  })
end

return M

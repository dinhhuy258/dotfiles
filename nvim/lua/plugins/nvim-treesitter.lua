local M = {}

M.setup = function()
  -- Enable treesitter indent for all filetypes
  -- Note: highlight is enabled by default in Neovim 0.12
  vim.api.nvim_create_autocmd("FileType", {
    callback = function()
      if vim.treesitter.get_parser(0, nil, { error = false }) then
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end,
  })

  local ts_context_commentstring_ok, ts_context_commentstring = pcall(require, "ts_context_commentstring")
  if ts_context_commentstring_ok then
    ts_context_commentstring.setup {}
    vim.g.skip_ts_context_commentstring_module = true
  end
end

return M

local M = {}

function M.setup()
  local cursorword_ok, cursorword = pcall(require, "mini.cursorword")
  if not cursorword_ok then
    return
  end

  local group = vim.api.nvim_create_augroup("dotfiles_filetype_minicursorword_disable", { clear = true })

  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = {
      "sfm",
      "VimDatabase",
      "git.nvim"
    },
    callback = function()
      vim.b.minicursorword_disable = true
    end,
  })

  cursorword.setup()
end

return M

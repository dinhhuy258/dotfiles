local M = {}

function M.stop_hlsearch()
  if vim.v.hlsearch == 1 and vim.fn.mode() == "n" and vim.api.nvim_win_get_config(0)["relative"] == "" then
    vim.fn.feedkeys "<dotfiles>(stop_hightlight_search)"
  end
end

function M.setup()
  vim.cmd "noremap <silent> <dotfiles>(stop_hightlight_search) :<C-U>nohlsearch<CR>"
  vim.cmd "noremap! <expr> <dotfiles>(stop_hightlight_search) execute('nohlsearch')[-1]"

  vim.api.nvim_create_autocmd("CursorMoved", {
    pattern = "*",
    callback = function()
      vim.cmd [[
        if v:hlsearch && !search('\%#\zs'.@/,'cnW')
          call luaeval("require'core.nohlsearch'.stop_hlsearch()")
        endif
      ]]
    end,
  })

  vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    callback = function()
      require("core.nohlsearch").stop_hlsearch()
    end,
  })
end

return M

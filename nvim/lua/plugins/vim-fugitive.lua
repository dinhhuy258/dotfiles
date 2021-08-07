local M = {}

M.setup = function()
  require("utils").set_keymap("n", "<Leader>gb", ":Git blame<CR>", { noremap = true })
  require("general.autocmds").define_augroups {
    _vim_fugitive = {
      {
        "FileType",
        "fugitiveblame",
        "nnoremap <silent> <buffer> q :q<CR>",
      },
    },
  }
end

return M

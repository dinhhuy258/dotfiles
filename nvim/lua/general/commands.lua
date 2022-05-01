local M = {}

function M.setup()
  vim.cmd "command! FixWhitespace :%s/\\s\\+$//e"
  vim.cmd "command! StartProfiling profile start ~/.profile.log | profile func * | profile file * | echo 'Profiling started'"

  -- Abbreviations
  vim.cmd "cnoreabbrev W! w!"
  vim.cmd "cnoreabbrev Q! q!"
  vim.cmd "cnoreabbrev Qall! qall!"
  vim.cmd "cnoreabbrev Wq wq"
  vim.cmd "cnoreabbrev Wa wa"
  vim.cmd "cnoreabbrev wQ wq"
  vim.cmd "cnoreabbrev WQ wq"
  vim.cmd "cnoreabbrev W w"
  vim.cmd "cnoreabbrev Q q"
  vim.cmd "cnoreabbrev Qall qall"
end

return M

local M = {}

M.setup = function()
  -- A message will be appear in the message line when you're in a submode
  -- and stay there until the mode has existed
  vim.g.submode_always_show_submode = 1
  vim.g.submode_keep_leaving_key = 1
  vim.g.submode_timeout = 0

  -- Windows
  vim.call('submode#enter_with', 'window', 'n', '', '<C-w>')
  vim.call('submode#map', 'window', 'n', '', 'h', ':vertical resize -3<CR>')
  vim.call('submode#map', 'window', 'n', '', 'l', ':vertical resize +3<CR>')
  vim.call('submode#map', 'window', 'n', '', 'j', ':resize -3<CR>')
  vim.call('submode#map', 'window', 'n', '', 'k', ':resize +3<CR>')
  vim.call('submode#leave_with', 'window', 'n', '', '<ESC>')
end

return M

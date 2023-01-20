local M = {}

function M.buf_set(buffer, mode, key, func_or_command, options)
  options = table.merge({
    noremap = true,
    silent = true,
    expr = false,
  }, options or {})

  vim.api.nvim_buf_set_keymap(buffer, mode, key, func_or_command, options)
end

function M.set(mode, key, func_or_command, options)
  options = table.merge({
    noremap = true,
    silent = true,
    expr = false,
  }, options or {})

  vim.api.nvim_set_keymap(mode, key, func_or_command, options)
end

return M

local utils = {}

function table.merge(dest, src)
  for k, v in pairs(src) do
    dest[k] = v
  end

  return dest
end

function utils.set_keymap(mode, key, func_or_command, options)
  options = table.merge({
    noremap = true,
    silent = true,
    expr = false
  }, options or {})

  vim.api.nvim_set_keymap(mode, key, func_or_command, options)
end

return utils

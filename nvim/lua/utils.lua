local M = {}

function table.merge(dest, src)
  for k, v in pairs(src) do
    dest[k] = v
  end

  return dest
end

function M.set_keymap(mode, key, func_or_command, options)
  options = table.merge({
    noremap = true,
    silent = true,
    expr = false,
  }, options or {})

  vim.api.nvim_set_keymap(mode, key, func_or_command, options)
end

function M.check_lsp_client_active(name)
  local clients = vim.lsp.get_active_clients()
  for _, client in pairs(clients) do
    if client.name == name then
      return true
    end
  end
  return false
end

function M.web_devicons_get_file_type_symbol(file_path)
  local filename = vim.fn.fnamemodify(file_path, ":t")
  local extension = vim.fn.fnamemodify(file_path, ":e")

  return require("nvim-web-devicons").get_icon(filename, extension, { default = true })
end

return M

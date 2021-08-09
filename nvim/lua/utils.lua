local M = {}

local function echo_multiline(msg)
  for _, s in ipairs(vim.fn.split(msg, "\n")) do
    vim.cmd("echom '" .. s:gsub("'", "''") .. "'")
  end
end

function table.merge(dest, src)
  for k, v in pairs(src) do
    dest[k] = v
  end

  return dest
end

function M.buf_set_keymap(buffer, mode, key, func_or_command, options)
  options = table.merge({
    noremap = true,
    silent = true,
    expr = false,
  }, options or {})

  vim.api.nvim_buf_set_keymap(buffer, mode, key, func_or_command, options)
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

function M.info(msg)
  vim.cmd "echohl Directory"
  echo_multiline(msg)
  vim.cmd "echohl None"
end

function M.warn(msg)
  vim.cmd "echohl WarningMsg"
  echo_multiline(msg)
  vim.cmd "echohl None"
end

function M.err(msg)
  vim.cmd "echohl ErrorMsg"
  echo_multiline(msg)
  vim.cmd "echohl None"
end

return M

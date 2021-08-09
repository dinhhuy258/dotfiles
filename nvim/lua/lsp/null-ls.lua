local M = {}

local utils = require "utils"

M.requested_providers = {}

local function register_failed_request(ft, provider, operation)
  if not lsp_clients[ft][operation]._failed_requests then
    lsp_clients[ft][operation]._failed_requests = {}
  end

  table.insert(lsp_clients[ft][operation]._failed_requests, provider)
end

local function validate_provider_request(provider)
  if provider == "" or provider == nil then
    return
  end

  if vim.fn.executable(provider._opts.command) ~= 1 then
    utils.warn(string.format("Unable to find the path for: [%s]", vim.inspect(provider)))
    return
  end
  return provider._opts.command
end

function M.setup(filetype)
  local status_ok, null_ls = pcall(require, "null-ls")
  if not status_ok then
    return
  end

  for _, formatter in pairs(lsp_clients[filetype].formatters) do
    local builtin_formatter = null_ls.builtins.formatting[formatter.exe]
    if not vim.tbl_contains(M.requested_providers, builtin_formatter) then
      local resolved_path = validate_provider_request(builtin_formatter)
      if resolved_path then
        builtin_formatter._opts.command = resolved_path
        table.insert(M.requested_providers, builtin_formatter)
        utils.info(string.format("Using format provider: [%s]", builtin_formatter.name))
      else
        -- mark it here to avoid re-doing the lookup again
        register_failed_request(filetype, formatter.exe, "formatters")
      end
    end
  end

  for _, linter in pairs(lsp_clients[filetype].linters) do
    local builtin_diagnoser = null_ls.builtins.diagnostics[linter.exe]
    if not vim.tbl_contains(M.requested_providers, builtin_diagnoser) then
      local resolved_path = validate_provider_request(builtin_diagnoser)
      if resolved_path then
        builtin_diagnoser._opts.command = resolved_path
        table.insert(M.requested_providers, builtin_diagnoser)
        utils.info(string.format("Using linter provider: [%s]", builtin_diagnoser.name))
      else
        -- mark it here to avoid re-doing the lookup again
        register_failed_request(filetype, linter.exe, "linters")
      end
    end
  end

  null_ls.register { sources = M.requested_providers }
end

return M

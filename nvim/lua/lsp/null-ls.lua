local M = {}

local utils = require "utils"

local requested_providers = {}

local failed_providers = {
  linters = {},
  formatters = {},
}

local function register_failed_request(provider, operation)
  if operation == "linters" then
    utils.warn(string.format("Linter provider [%s] is not supported", provider))
  else
    utils.warn(string.format("Format provider [%s] is not supported", provider))
  end

  table.insert(failed_providers[operation], provider)
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
    if
      vim.tbl_contains(requested_providers, builtin_formatter)
      or vim.tbl_contains(failed_providers.formatters, formatter.exe)
    then
      return
    end

    local resolved_path = validate_provider_request(builtin_formatter)
    if resolved_path then
      builtin_formatter._opts.command = resolved_path
      table.insert(requested_providers, builtin_formatter)
      utils.info(string.format("Using format provider: [%s]", builtin_formatter.name))
    else
      -- mark it here to avoid re-doing the lookup again
      register_failed_request(formatter.exe, "formatters")
    end
  end

  for _, linter in pairs(lsp_clients[filetype].linters) do
    local builtin_diagnoser = null_ls.builtins.diagnostics[linter.exe]
    if
      vim.tbl_contains(requested_providers, builtin_diagnoser)
      or vim.tbl_contains(failed_providers.linters, linter.exe)
    then
      return
    end

    local resolved_path = validate_provider_request(builtin_diagnoser)
    if resolved_path then
      builtin_diagnoser._opts.command = resolved_path
      table.insert(requested_providers, builtin_diagnoser)
      utils.info(string.format("Using linter provider: [%s]", builtin_diagnoser.name))
    else
      -- mark it here to avoid re-doing the lookup again
      register_failed_request(linter.exe, "linters")
    end
  end

  null_ls.register { sources = requested_providers }
end

return M

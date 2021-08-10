local utils = require "utils"
local config = require "fzf-lua.config"
local core = require "fzf-lua.core"

local M = {}

local labels = {
  ["textDocument/references"] = {
    label = "References",
  },
  ["textDocument/definition"] = {
    label = "Definitions",
  },
  ["goto_declaration"] = {
    label = "Declarations",
  },
  ["textDocument/typeDefinition"] = {
    label = "Type Definitions",
  },
  ["textDocument/implementation"] = {
    label = "Implementations",
  },
}

local function check_capabilities(feature)
  local lsp_clients = vim.lsp.buf_get_clients(0)
  if #lsp_clients == 0 then
    utils.info "LSP: no client attached"
    return
  end

  for _, lsp_client in pairs(lsp_clients) do
    if lsp_client.resolved_capabilities[feature] then
      return true
    end
  end

  utils.info("LSP: server does not support " .. feature)
  return false
end

local function location_handler(err, method, lsp_results)
  if err then
    utils.err(err.message)
    return
  end

  local label = labels[method].label
  if lsp_results == nil or vim.tbl_isempty(lsp_results) then
    utils.info("LSP: No " .. label:lower() .. " found")
    return
  end

  if #lsp_results == 1 then
    vim.lsp.util.jump_to_location(lsp_results[1])
    return
  end

  local cfg = config.globals.lsp
  local opts = config.normalize_opts({}, cfg)
  opts.cwd = vim.loop.cwd()
  opts.prompt = label .. cfg.prompt
  opts = core.set_fzf_line_args(opts)

  local lsp_items = {}
  local items = vim.lsp.util.locations_to_items(lsp_results)
  for _, entry in ipairs(items) do
    entry = core.make_entry_lcol(opts, entry)
    entry = core.make_entry_file(opts, entry)
    table.insert(lsp_items, entry)
  end

  opts.fzf_fn = lsp_items
  core.fzf_files(opts)
end

local handlers = {
  ["references"] = {
    capability = "find_references",
    method = "textDocument/references",
    handler = location_handler,
  },
  ["definitions"] = {
    capability = "goto_definition",
    method = "textDocument/definition",
    handler = location_handler,
  },
  ["declarations"] = {
    label = "Declarations",
    capability = "goto_declaration",
    method = "textDocument/declaration",
    handler = location_handler,
  },
  ["typedefs"] = {
    capability = "type_definition",
    method = "textDocument/typeDefinition",
    handler = location_handler,
  },
  ["implementations"] = {
    capability = "implementation",
    method = "textDocument/implementation",
    handler = location_handler,
  },
}

local function fzf_lsp_locations(opts)
  local params = vim.lsp.util.make_position_params()
  vim.lsp.buf_request(0, opts.lsp_handler.method, params, opts.lsp_handler.handler)
end

M.definitions = function(opts)
  fzf_lsp_locations(opts)
end

M.references = function(opts)
  fzf_lsp_locations(opts)
end

M.declarations = function(opts)
  return fzf_lsp_locations(opts)
end

M.typedefs = function(opts)
  fzf_lsp_locations(opts)
end

M.implementations = function(opts)
  fzf_lsp_locations(opts)
end

local function wrap_module_fncs(mod)
  for k, v in pairs(mod) do
    mod[k] = function()
      local opts = {}
      opts.lsp_handler = handlers[k]
      if not opts.lsp_handler then
        utils.err(string.format("No LSP handler defined for %s", k))
        return
      end
      if not check_capabilities(opts.lsp_handler.capability) then
        return
      end
      v(opts)
    end
  end

  return mod
end

return wrap_module_fncs(M)

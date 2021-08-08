local utils = require "fzf-lua.utils"
local config = require "fzf-lua.config"
local core = require "fzf-lua.core"

local M = {}

local function location_handler(_, _, lsp_results)
  if lsp_results == nil or vim.tbl_isempty(lsp_results) then
    utils.info "LSP: No result"
    return
  end

  if #lsp_results == 1 then
    vim.lsp.util.jump_to_location(lsp_results[1])
    return
  end

  local cfg = config.globals.lsp

  local opts = config.normalize_opts({}, cfg)
  opts.cwd = vim.loop.cwd()
  opts.prompt = cfg.prompt
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

function M.definitions()
  local params = vim.lsp.util.make_position_params()
  vim.lsp.buf_request(0, "textDocument/definition", params, location_handler)
end

return M

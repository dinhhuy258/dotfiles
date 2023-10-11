local M = {}

local config = {
  lua = { "stylua", "--search-parent-directories", "-" },
  markdown = { "prettier", "--stdin-filepath", "$FILENAME" },
  proto = { "clang-format", "$FILENAME" },
}

local handle_job_data = function(data)
  if not data then
    return nil
  end
  if data[#data] == "" then
    table.remove(data, #data)
  end
  if #data < 1 then
    return nil
  end
  return data
end

function M.is_supported(filetype)
  return config[filetype] ~= nil
end

function M.format()
  local modifiable = vim.bo.modifiable
  if not modifiable then
    vim.notify "Buffer is not modifiable"
    return
  end

  local filetype = vim.bo.filetype
  local args = config[filetype]
  if args == nil then
    vim.notify("No formatter found for filetype " .. filetype)
    return
  end

  for idx, arg in ipairs(args) do
    if arg == "$FILENAME" then
      args[idx] = vim.api.nvim_buf_get_name(0)
    end
  end

  local job_id = vim.fn.jobstart(args, {
    on_stdout = function(_, data, _)
      data = handle_job_data(data)
      if not data then
        return
      end

      vim.api.nvim_buf_set_lines(0, 0, -1, false, data)
      vim.api.nvim_command "write"
    end,
    stdout_buffered = true,
    stderr_buffered = true,
  })

  vim.fn.chansend(job_id, vim.api.nvim_buf_get_lines(0, 0, -1, false))
  vim.fn.chanclose(job_id, "stdin")
end

function M.setup()
  vim.api.nvim_command [[
    autocmd FileType markdown,proto nnoremap <buffer> <Leader>cf :lua require'core.formatter'.format()<CR>
  ]]
end

return M

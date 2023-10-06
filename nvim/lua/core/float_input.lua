local M = {}

function M.input(on_confirm, opts)
  opts = opts or {}
  local prompt = opts.prompt or "Input: "
  local default = opts.default or ""
  local input_width = opts.width or math.floor(vim.o.columns / 5)
  local input_height = opts.height or 1
  local winhl = opts.winhl or "Normal:Normal,FloatBorder:Normal,FloatTitle:Normal"
  local win_config = opts.win_config or {}

  win_config = vim.tbl_deep_extend("force", {
    focusable = true,
    style = "minimal",
    border = "rounded",
    width = input_width,
    height = input_height,
    title = prompt,
    relative = "win",
    row = vim.api.nvim_win_get_height(0) / 2 - 1,
    col = vim.api.nvim_win_get_width(0) / 2 - input_width / 2,
  }, win_config)

  -- create floating window.
  local buffer = vim.api.nvim_create_buf(false, true)
  local window = vim.api.nvim_open_win(buffer, true, win_config)
  vim.api.nvim_buf_set_text(buffer, 0, 0, 0, 0, { default })

  -- window option settings
  vim.api.nvim_win_set_option(window, "winhl", winhl)

  -- put cursor at the end of the default value
  vim.cmd "startinsert"
  vim.api.nvim_win_set_cursor(window, { 1, vim.str_utfindex(default) + 1 })

  -- enter to confirm
  vim.keymap.set({ "n", "i", "v" }, "<cr>", function()
    local lines = vim.api.nvim_buf_get_lines(buffer, 0, 1, false)
    if lines[1] ~= default and on_confirm then
      on_confirm(lines[1])
    end

    vim.api.nvim_win_close(window, true)
    vim.cmd "stopinsert"
  end, { buffer = buffer })

  -- ctr-c, esc or q to close
  vim.keymap.set("n", "<esc>", function()
    vim.api.nvim_win_close(window, true)
  end, { buffer = buffer })
  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(window, true)
  end, { buffer = buffer })
  vim.keymap.set({ "n", "i" }, "<c-c>", function()
    vim.api.nvim_win_close(window, true)
  end, { buffer = buffer })
end

return M

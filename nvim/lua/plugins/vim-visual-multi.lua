local M = {}

M.setup = function()
  vim.g.VM_default_mappings = 0
  vim.g.VM_add_cursor_at_pos_no_mappings = 1

  local function visual_cursors_with_delay()
    -- Execute the vm-visual-cursors command.
    vim.cmd 'silent! execute "normal! \\<Plug>(VM-Visual-Cursors)"'
    -- Introduce delay via VimScript's 'sleep' (set to 500 milliseconds here).
    vim.cmd "sleep 200m"
    -- Press 'A' in normal mode after the delay.
    vim.cmd 'silent! execute "normal! A"'
  end

  local wk = require "which-key"
  wk.add {
    { "<Leader>m", group = "Visual Multi", mode = "n" },
    { "<Leader>ma", "<Plug>(VM-Select-All)<Tab>", desc = "Select All", mode = "n" },
    { "<Leader>mo", "<Plug>(VM-Toggle-Mappings)", desc = "Toggle Mapping", mode = "n" },
    { "<Leader>mp", "<Plug>(VM-Add-Cursor-At-Pos)", desc = "Add Cursor At Pos", mode = "n" },
    { "<Leader>mr", "<Plug>(VM-Start-Regex-Search)", desc = "Start Regex Search", mode = "n" },
    {
      "<Leader>mv",
      function()
        visual_cursors_with_delay()
      end,
      desc = "Visual Cursors",
      mode = "v",
    },
  }
end

return M

local keymaps = require "config.keymaps"

local M = {}

function M.setup(bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = desc }
  end

  local wk_ok, wk = pcall(require, "which-key")
  if wk_ok then
    wk.add {
      { "gn", group = "Diagnostics", buffer = bufnr },
      { "<Leader>c", group = "Code", buffer = bufnr },
      { "<Leader>h", group = "Hints", buffer = bufnr },
    }
  end

  -- Navigation
  keymaps.set("n", "gd", "<CMD>lua require('telescope.builtin').lsp_definitions()<CR>", opts "Go to definition")
  keymaps.set("n", "gr", "<CMD>lua require('telescope.builtin').lsp_references()<CR>", opts "Go to references")
  keymaps.set("n", "gi", "<CMD>lua require('telescope.builtin').lsp_implementations()<CR>", opts "Go to implementation")
  keymaps.set(
    "n",
    "gy",
    "<CMD>lua require('telescope.builtin').lsp_type_definitions()<CR>",
    opts "Go to type definition"
  )

  -- Code actions
  keymaps.set("n", "<Leader>ca", "<CMD>lua vim.lsp.buf.code_action()<CR>", opts "Code action")
  keymaps.set("n", "<Leader>cr", "<CMD>lua vim.lsp.buf.rename()<CR>", opts "Rename symbol")

  -- Diagnostics navigation
  keymaps.set("n", "gnN", function()
    vim.diagnostic.jump {
      count = -1,
      float = true,
    }
  end, opts "Previous diagnostic")

  keymaps.set("n", "gnn", function()
    vim.diagnostic.jump {
      count = 1,
      float = true,
    }
  end, opts "Next diagnostic")

  keymaps.set("n", "gno", function()
    vim.diagnostic.open_float { border = "rounded", focusable = true, focus = true }
  end, opts "Open diagnostic float")

  keymaps.set("n", "gny", function()
    local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line "." - 1 })
    if #diagnostics > 0 then
      local message = diagnostics[1].message
      vim.fn.setreg("+", message)
      vim.notify("Diagnostic copied to clipboard", vim.log.levels.INFO)
    else
      vim.notify("No diagnostic on current line", vim.log.levels.WARN)
    end
  end, opts "Yank diagnostic message")

  -- Hover and signature help with rounded borders
  keymaps.set("n", "K", function()
    vim.lsp.buf.hover { border = "rounded" }
  end, opts "Hover documentation")

  -- Inlay hints toggle
  keymaps.set("n", "<Leader>hh", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }, { bufnr = bufnr })
  end, opts "Toggle inlay hints")
end

return M

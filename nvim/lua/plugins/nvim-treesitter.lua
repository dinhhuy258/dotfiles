local M = {}

M.setup = function()
  local status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
  if not status_ok then
    return
  end

  treesitter_configs.setup {
    ensure_installed = "all",
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
    endwise = {
      enable = true,
    },
    -- nvim-treesitter-textobjects
    textobjects = {
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]f"] = "@function.outer",
          ["]c"] = "@class.outer",
          ["]a"] = "@parameter.inner",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
          ["[c"] = "@class.outer",
          ["[a"] = "@parameter.inner",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<Leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<Leader>A"] = "@parameter.inner",
        },
      },
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["ia"] = "@parameter.inner",
        },
      },
    },
  }
end

return M

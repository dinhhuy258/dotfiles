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
    -- windwp/nvim-ts-autotag
    autotag = {
      enable = true,
    },
    -- nvim-treesitter-endwise
    endwise = {
      enable = true,
    },
    -- nvim-ts-context-commentstring
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
    -- nvim-treesitter-textobjects
    textobjects = {
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["gcf"] = "@function.outer",
          ["gcc"] = "@class.outer",
          ["gcp"] = "@parameter.inner",
        },
        goto_previous_start = {
          ["gcF"] = "@function.outer",
          ["gcC"] = "@class.outer",
          ["gcP"] = "@parameter.inner",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["swa"] = "@parameter.inner",
        },
        swap_previous = {
          ["swA"] = "@parameter.inner",
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
          ["ip"] = "@parameter.inner",
        },
      },
    },
  }

  local treesitter_context_status_ok, treesitter_context = pcall(require, "treesitter-context")
  if not treesitter_context_status_ok then
    return
  end

  treesitter_context.setup {
    separator = "-",
  }
end

return M

local M = {}

M.setup = function()
  local status_ok, _ = pcall(require, "nvim-autopairs")
  if not status_ok then
    return
  end

  local npairs = require "nvim-autopairs"
  local Rule = require "nvim-autopairs.rule"

  if package.loaded["compe"] then
    require("nvim-autopairs.completion.compe").setup {
      map_cr = true, --  map <CR> on insert mode
      map_complete = true, -- it will auto insert `(` after select function or method item
    }
  end

  npairs.setup {
    check_ts = true,
    ts_config = {
      lua = { "string" }, -- it will not add pair on that treesitter node
      javascript = { "template_string" },
      java = false, -- don't check treesitter on java
    },
  }

  require("nvim-treesitter.configs").setup { autopairs = { enable = true } }

  local ts_conds = require "nvim-autopairs.ts-conds"

  -- press % => %% is only inside comment or string
  npairs.add_rules {
    Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node { "string", "comment" }),
    Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node { "function" }),
  }
end

return M

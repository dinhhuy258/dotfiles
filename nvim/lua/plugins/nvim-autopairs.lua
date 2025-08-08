local M = {}

M.setup = function()
  local autopairs = require "nvim-autopairs"
  local Rule = require "nvim-autopairs.rule"
  local cond = require "nvim-autopairs.conds"

  autopairs.setup {
    check_ts = true,
    ts_config = {
      lua = { "string" }, -- it will not add a pair on that treesitter node
      javascript = { "template_string" },
      java = false,       -- don't check treesitter on java
    },
  }

  autopairs.add_rule(Rule("$$", "$$", "tex"))
  autopairs.add_rules {
    Rule("$", "$", { "tex", "latex" })                  -- don't add a pair if the next character is %
        :with_pair(cond.not_after_regex_check "%%")     -- don't add a pair if  the previous character is xxx
        :with_pair(cond.not_before_regex_check("xxx", 3)) -- don't move right when repeat character
        :with_move(cond.none())                         -- don't delete if the next character is xx
        :with_del(cond.not_after_regex_check "xx")      -- disable  add newline when press <cr>
        :with_cr(cond.none()),
  }
  autopairs.add_rules {
    Rule("$$", "$$", "tex"):with_pair(function(opts)
      print(vim.inspect(opts))
      if opts.line == "aa $$" then
        -- don't add pair on that line
        return false
      end
    end),
  }

  -- Note: blink.cmp handles auto brackets via its own configuration
  -- No need for cmp integration since we're using blink.cmp

  require("nvim-treesitter.configs").setup { autopairs = { enable = true } }
  local ts_conds = require "nvim-autopairs.ts-conds"

  -- TODO: can these rules be safely added from "config.lua" ?
  -- press % => %% is only inside comment or string
  autopairs.add_rules {
    Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node { "string", "comment" }),
    Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node { "function" }),
  }
end

return M

local plugin_loader = {}

--- @private
local function _load_plugins(opts)
  require("lazy").setup({
    -- colorscheme
    {
      "folke/tokyonight.nvim",
      lazy = false, -- make sure to load this during startup
      priority = 1000, -- make sure to load this before all the other start plugins
    },
    -- intellij as language server
    {
      "dinhhuy258/vintellij",
      branch = "lsp",
      ft = { "kotlin", "java", "ruby" },
      config = function()
        require("plugins.vintellij").setup()
      end,
    },
    {
      "mfussenegger/nvim-jdtls",
      ft = "java",
      config = function ()
        require("plugins.jdtls").setup()
      end
    },
    -- local history in vim
    { "dinhhuy258/vim-local-history" },
    -- vim database
    { "dinhhuy258/vim-database" },
    -- file explorer
    {
      "dinhhuy258/sfm.nvim",
      dependencies = {
        "dinhhuy258/sfm-bookmark.nvim",
        "dinhhuy258/sfm-filter.nvim",
        "dinhhuy258/sfm-git.nvim",
        "dinhhuy258/sfm-telescope.nvim",
        "dinhhuy258/sfm-paste.nvim",
      },
      config = function()
        require("plugins.sfm").setup()
      end,
    },
    -- git
    {
      "dinhhuy258/git.nvim",
      config = function()
        require("plugins.git").setup()
      end,
    },
    -- tmux integration for nvim
    {
      "aserowy/tmux.nvim",
      config = function()
        require("plugins.tmux").setup()
      end,
    },
    -- highlighting
    {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
        "nvim-treesitter/nvim-treesitter-textobjects",
        "RRethy/nvim-treesitter-endwise",
        "windwp/nvim-ts-autotag",
      },
      config = function()
        require("plugins.nvim-treesitter").setup()
      end,
    },
    -- formating
    {
      "stevearc/conform.nvim",
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        require("plugins.conform").setup()
      end,
    },
    -- linting
    {
      "mfussenegger/nvim-lint",
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        require("plugins.nvim-lint").setup()
      end,
    },
    -- adds file type icons to Vim plugins such as: nvim-tree.lua, galaxyline.nvim, vim-startify...
    { "kyazdani42/nvim-web-devicons" },
    -- gitsigns, telescope... depend on this library
    { "nvim-lua/plenary.nvim" },
    -- fzf
    {
      "ibhagwan/fzf-lua",
      dependencies = {
        "vijaymarupudi/nvim-fzf",
      },
      config = function()
        require("plugins.fzf-lua").setup()
      end,
    },
    -- telescope
    {
      "nvim-telescope/telescope.nvim",
      dependencies = {
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",
      },
      config = function()
        require("plugins.telescope").setup()
      end,
    },
    -- show git diff in the sign column
    {
      "lewis6991/gitsigns.nvim",
      event = "BufRead",
      config = function()
        require("plugins.gitsigns").setup()
      end,
    },
    -- vim easy motion
    {
      "phaazon/hop.nvim",
      config = function()
        require("plugins.hop").setup()
      end,
    },
    -- vim surround
    {
      "kylechui/nvim-surround",
      event = "BufRead",
      config = function()
        require("nvim-surround").setup()
      end,
    },
    -- enable repeating supported plugins map with .
    {
      "tpope/vim-repeat",
      event = "BufRead",
    },
    -- make f, F, t, T more clever
    {
      "rhysd/clever-f.vim",
      event = "BufRead",
      config = function()
        require("plugins.clever-f").setup()
      end,
    },
    -- tabline plugin
    {
      "romgrk/barbar.nvim",
      event = "BufWinEnter",
      config = function()
        require("plugins.barbar").setup()
      end,
    },
    -- the fancy start screen
    {
      "mhinz/vim-startify",
      event = "BufWinEnter",
      config = function()
        require("plugins.vim-startify").setup()
      end,
    },
    -- manage lsp servers
    {
      "williamboman/mason.nvim",
      dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
      },
      config = function()
        require("plugins.mason").setup()
      end,
    },
    -- lsp signature
    {
      "ray-x/lsp_signature.nvim",
      event = "BufRead",
      config = function()
        require("lsp_signature").setup()
      end,
    },
    -- auto completion
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        -- snippet
        {
          dependencies = {
            "rafamadriz/friendly-snippets",
            "saadparwaiz1/cmp_luasnip",
          },
          "L3MON4D3/LuaSnip",
          build = "make install_jsregexp",
          config = function()
            require("lsp_signature").setup()
          end,
        },
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
      },
      event = "InsertEnter",
      config = function()
        require("plugins.nvim-cmp").setup()
      end,
    },
    { "folke/neodev.nvim" },
    -- autopair
    {
      "windwp/nvim-autopairs",
      dependencies = {
        "nvim-cmp",
      },
      config = function()
        require("plugins.nvim-autopairs").setup()
      end,
    },
    -- comment
    {
      "numToStr/Comment.nvim",
      event = "BufRead",
      dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
      },
      config = function()
        require("plugins.comment").setup()
      end,
    },
    -- indent guides
    {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufRead",
      main = "ibl",
      config = function()
        require("plugins.indent-blankline").setup()
      end,
    },
    -- go
    {
      "mfussenegger/nvim-dap",
      ft = {
        "go",
        "ruby",
        "php",
      },
      dependencies = {
        "rcarriga/nvim-dap-ui",
        "suketa/nvim-dap-ruby",
      },
      config = function()
        require("plugins.nvim-dap").setup()
      end,
    },
    {
      "dinhhuy258/go.nvim",
      dependencies = {
        "nvim-dap",
        "nvim-dap-ui",
      },
      ft = { "go" },
      config = function()
        require("plugins.go").setup()
      end,
    },
    -- docs generation
    {
      "danymat/neogen",
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
      },
      config = function()
        require("neogen").setup {}
      end,
    },
    {
      "sustech-data/wildfire.nvim",
      event = "VeryLazy",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      config = function()
        require("wildfire").setup()
      end,
    },
    -- spliting/ joining blocks of code
    {
      "Wansmer/treesj",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      config = function()
        require("plugins.treesj").setup()
      end,
    },
    {
      "ThePrimeagen/harpoon",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
      },
      config = function()
        require("plugins.harpoon").setup()
      end,
    },
    -- for interacting with tests within NeoVim
    {
      "vim-test/vim-test",
      dependencies = {
        "preservim/vimux",
      },
      config = function()
        require("plugins.vim-test").setup()
      end,
    },
    -- copilot
    {
      "zbirenbaum/copilot.lua",
      event = "BufRead",
      config = function()
        require("plugins.copilot").setup()
      end,
    },
    -- easily interact with tmux from vim
    { "preservim/vimux" },
    -- peek file
    {
      "nacro90/numb.nvim",
      config = function()
        require("numb").setup()
      end,
    },
    {
      "echasnovski/mini.cursorword",
      config = function()
        require("plugins.cursorword").setup()
      end,
    },
    {
      "SmiteshP/nvim-navbuddy",
      dependencies = {
        "SmiteshP/nvim-navic",
        "MunifTanjim/nui.nvim",
      },
      opts = {
        lsp = {
          auto_attach = true,
        },
      },
      config = function()
        require("plugins.nvim-navbuddy").setup()
      end,
    },
    {
      "utilyre/barbecue.nvim",
      dependencies = {
        "SmiteshP/nvim-navic",
        "kyazdani42/nvim-web-devicons",
      },
      config = function()
        require("barbecue").setup()
      end,
    },
    {
      "tpope/vim-abolish",
    },
    {
      "tpope/vim-rails",
      ft = {
        "ruby",
      },
    },
    {
      "max397574/better-escape.nvim",
      config = function()
        require("better_escape").setup()
      end,
    },
    {
      "kevinhwang91/nvim-ufo",
      dependencies = {
        "kevinhwang91/promise-async",
        {
          "luukvbaal/statuscol.nvim",
        },
      },
      config = function()
        require("plugins.nvim-ufo").setup()
      end,
    },
    {
      "vimwiki/vimwiki",
    },
  }, opts)
end

function plugin_loader:init()
  local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system { "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath }
    vim.fn.system { "git", "-C", lazypath, "checkout", "tags/stable" } -- last stable release
  end

  vim.opt.rtp:prepend(lazypath)

  -- load plugins
  _load_plugins {
    ui = {
      border = "rounded",
    },
    install = {
      missing = true,
    },
  }
end

return {
  init = function()
    return plugin_loader:init()
  end,
}

local plugin_loader = {}

--- @private
local function _load_plugins()
  require("lazy").setup {
    -- colorscheme
    {
      "folke/tokyonight.nvim",
      lazy = false, -- make sure we load this during startup if it is your main colorscheme
      priority = 1000, -- make sure to load this before all the other start plugins
    },
    -- intellij as language server
    {
      "dinhhuy258/vintellij",
      branch = "lsp",
      ft = { "kotlin", "java" },
      config = function()
        require("plugins.vintellij").setup()
      end,
    },
    -- vim utilities
    {
      "dinhhuy258/vim-utilities",
      config = function()
        local status_ok, utilities = pcall(require, "utilities")
        if status_ok then
          utilities.setup()
        end
      end,
    },
    -- local history in vim
    { "dinhhuy258/vim-local-history" },
    -- vim database
    { "dinhhuy258/vim-database" },
    -- file explorer
    {
      "dinhhuy258/sfm.nvim",
      dependencies = {
        { "dinhhuy258/sfm-bookmark.nvim" },
      },
      config = function()
        require("plugins.sfm").setup()
      end,
    },
    -- git
    {
      "dinhhuy258/git.nvim",
      config = function()
        local status_ok, git = pcall(require, "git")
        if status_ok then
          git.setup()
        end
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
      config = function()
        require("plugins.nvim-treesitter").setup()
      end,
    },
    -- textobjects
    { "nvim-treesitter/nvim-treesitter-textobjects" },
    -- adds file type icons to Vim plugins such as: nvim-tree.lua, galaxyline.nvim, vim-startify...
    { "kyazdani42/nvim-web-devicons" },
    -- gitsigns, telescope depend on this library
    { "nvim-lua/plenary.nvim" },
    -- fzf
    {
      "ibhagwan/fzf-lua",
      dependencies = {
        { "vijaymarupudi/nvim-fzf" },
      },
      config = function()
        require("plugins.fzf-lua").setup()
      end,
    },
    -- sets vim.ui.select to telescope
    {
      "nvim-telescope/telescope-ui-select.nvim",
    },
    -- telescope
    {
      "nvim-telescope/telescope.nvim",
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
      "tpope/vim-surround",
      event = "BufRead",
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
    -- multi editor tool for defining base file handling and code style preferences
    {
      "editorconfig/editorconfig-vim",
      event = "BufRead",
    },
    -- lsp client
    { "neovim/nvim-lspconfig" },
    -- manage lsp servers
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    -- lsp signature
    {
      "ray-x/lsp_signature.nvim",
      event = "BufRead",
      config = function()
        require("lsp_signature").setup()
      end,
    },
    -- snippet
    {
      "hrsh7th/vim-vsnip",
      event = "InsertEnter",
    },
    {
      "dinhhuy258/snippets",
      dependencies = "vim-vsnip",
    },
    -- auto completion
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        { "hrsh7th/cmp-nvim-lsp", dependencies = "nvim-cmp" },
        { "hrsh7th/cmp-vsnip", dependencies = "nvim-cmp" },
        { "hrsh7th/cmp-buffer", dependencies = "nvim-cmp" },
        { "hrsh7th/cmp-path", dependencies = "nvim-cmp" },
        { "hrsh7th/cmp-cmdline", dependencies = "nvim-cmp" },
      },
      event = "InsertEnter",
      config = function()
        require("plugins.nvim-cmp").setup()
      end,
    },
    -- autopair
    {
      "windwp/nvim-autopairs",
      dependencies = { "nvim-cmp" },
      config = function()
        require("plugins.nvim-autopairs").setup()
      end,
    },
    {
      "windwp/nvim-ts-autotag",
      event = "InsertEnter",
      config = function()
        require("plugins.nvim-ts-autotag").setup()
      end,
    },
    -- Comment
    {
      "numToStr/Comment.nvim",
      event = "BufRead",
      config = function()
        require("plugins.comment").setup()
      end,
    },
    -- indent guides
    {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufRead",
      config = function()
        require("plugins.indent-blankline").setup()
      end,
    },
    -- go
    {
      "mfussenegger/nvim-dap",
      ft = { "go" },
      config = function()
        require("plugins.nvim-dap").setup()
      end,
    },
    {
      "rcarriga/nvim-dap-ui",
      ft = { "go" },
      dependencies = { "nvim-dap" },
      config = function()
        local status_ok, dapui = pcall(require, "dapui")
        if status_ok then
          dapui.setup()
        end
      end,
    },
    {
      "dinhhuy258/go-tools.nvim",
      dependencies = { "nvim-dap" },
      ft = { "go" },
      config = function()
        require("plugins.go-tools").setup()
      end,
    },
    -- docs generation
    {
      "danymat/neogen",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      config = function()
        require("neogen").setup {}
      end,
    },
  }
end

function plugin_loader:init()
  local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    if not vim.loop.fs_stat(lazypath) then
      vim.fn.system { "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath }
      vim.fn.system { "git", "-C", lazypath, "checkout", "tags/stable" } -- last stable release
    end
  end

  vim.opt.rtp:prepend(lazypath)

  -- load plugins
  _load_plugins()
end

return {
  init = function()
    return plugin_loader:init()
  end,
}
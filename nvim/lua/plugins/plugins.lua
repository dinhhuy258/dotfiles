return {
  -- Packer can manage itself as an optional plugin
  { "wbthomason/packer.nvim" },
  -- Colorscheme
  {
    "folke/tokyonight.nvim",
  },
  -- Intellij as language server
  {
    "dinhhuy258/vintellij",
    branch = "lsp",
    ft = { "kotlin", "java" },
    config = function()
      require("plugins.vintellij").setup()
    end,
  },
  -- Vim utilities
  {
    "dinhhuy258/vim-utilities",
    config = function()
      local status_ok, utilities = pcall(require, "utilities")
      if status_ok then
        utilities.setup()
      end
    end,
  },
  -- Local history in vim
  { "dinhhuy258/vim-local-history" },
  -- Vim database
  { "dinhhuy258/vim-database" },
  -- File explorer
  {
    "dinhhuy258/nvim-tree.lua",
    config = function()
      require("plugins.nvim-tree").setup()
    end,
  },
  -- Git
  {
    "dinhhuy258/git.nvim",
    config = function()
      local status_ok, git = pcall(require, "git")
      if status_ok then
        git.setup()
      end
    end,
  },
  -- Tmux integration for nvim
  {
    "aserowy/tmux.nvim",
    config = function()
      require("plugins.tmux").setup()
    end,
  },
  -- Highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("plugins.nvim-treesitter").setup()
    end,
  },
  -- Textobjects
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  -- Adds file type icons to Vim plugins such as: nvim-tree.lua, galaxyline.nvim, vim-startify...
  { "kyazdani42/nvim-web-devicons" },
  -- gitsigns, telescope depend on this library
  { "nvim-lua/plenary.nvim" },
  -- Fzf
  {
    "ibhagwan/fzf-lua",
    requires = {
      { "vijaymarupudi/nvim-fzf" },
    },
    config = function()
      require("plugins.fzf-lua").setup()
    end,
  },
  -- Sets vim.ui.select to telescope
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("plugins.telescope").setup()
    end,
  },
  -- Show git diff in the sign column
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = function()
      require("plugins.gitsigns").setup()
    end,
  },
  -- Vim easy motion
  {
    "phaazon/hop.nvim",
    config = function()
      require("plugins.hop").setup()
    end,
  },
  -- Vim surround
  {
    "tpope/vim-surround",
    event = "BufRead",
  },
  -- Enable repeating supported plugins map with .
  {
    "tpope/vim-repeat",
    event = "BufRead",
  },
  -- Make f, F, t, T more clever
  {
    "rhysd/clever-f.vim",
    event = "BufRead",
    config = function()
      require("plugins.clever-f").setup()
    end,
  },
  -- Tabline plugin
  {
    "romgrk/barbar.nvim",
    event = "BufWinEnter",
    config = function()
      require("plugins.barbar").setup()
    end,
  },
  -- The fancy start screen
  {
    "mhinz/vim-startify",
    event = "BufWinEnter",
    config = function()
      require("plugins.vim-startify").setup()
    end,
  },
  -- Multi editor tool for defining base file handling and code style preferences
  {
    "editorconfig/editorconfig-vim",
    event = "BufRead",
  },
  -- Modify variable name to snake_case, camelCase, UPPER_CASE...
  {
    "tpope/vim-abolish",
    event = "BufRead",
  },
  -- LSP client
  { "neovim/nvim-lspconfig" },
  -- Provides the missing :LspInstall for nvim-lspconfig
  { "williamboman/nvim-lsp-installer" },
  -- Lsp signature
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require("lsp_signature").setup()
    end,
  },
  -- Snippet
  {
    "hrsh7th/vim-vsnip",
    event = "InsertEnter",
  },
  -- Set of preconfigured snippets for different languages.
  {
    "dinhhuy258/snippets",
    after = "vim-vsnip",
  },
  -- Completion
  {
    "hrsh7th/nvim-cmp",
    requires = {
      { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
      { "hrsh7th/cmp-vsnip", after = "nvim-cmp" },
      { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
      { "hrsh7th/cmp-path", after = "nvim-cmp" },
      { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
    },
    config = function()
      require("plugins.nvim-cmp").setup()
    end,
  },
  -- Autopair
  {
    "windwp/nvim-autopairs",
    after = "nvim-cmp",
    config = function()
      require("plugins.nvim-autopairs").setup()
    end,
  },
  -- Autopair
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
  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      require("plugins.indent-blankline").setup()
    end,
  },
  -- Debugging
  {
    "mfussenegger/nvim-dap",
    ft = { "go" },
    config = function()
      require("plugins.nvim-dap").setup()
    end,
  },
  -- UI for nvim-dap
  {
    "rcarriga/nvim-dap-ui",
    after = "nvim-dap",
    config = function()
      local status_ok, dapui = pcall(require, "dapui")
      if status_ok then
        dapui.setup()
      end
    end,
  },
  -- Go tools
  {
    "dinhhuy258/go-tools.nvim",
    after = { "nvim-dap" },
    config = function()
      require("plugins.go-tools").setup()
    end,
  },
  -- Neovim plugin for GitHub Copilot
  {
    "github/copilot.vim",
    event = "BufRead",
    config = function()
      require("plugins.copilot").setup()
    end,
  },
  -- Improve startup time for Neovim
  {
    "lewis6991/impatient.nvim",
    config = function()
      require("plugins.impatient").setup()
    end,
  },
}

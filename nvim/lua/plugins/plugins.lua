return {
  -- Packer can manage itself as an optional plugin
  { "wbthomason/packer.nvim" },
  -- Intellij as language server
  {
    "dinhhuy258/vintellij",
    branch = "lsp",
    event = "BufRead",
  },
  -- Vim utilities
  { "dinhhuy258/vim-utilities" },
  -- Local history in vim
  {
    "dinhhuy258/vim-local-history",
    run = ":UpdateRemotePlugins",
    event = "BufRead",
  },
  -- Open git repository
  { "dinhhuy258/vim-git-browse" },
  -- Vim database
  { "dinhhuy258/vim-database" },
  -- File explorer
  {
    "dinhhuy258/nvim-tree.lua",
    config = function()
      require("plugins.nvim-tree").setup()
    end,
  },
  -- Seamless navigation between tmux panes and vim splits
  { "christoomey/vim-tmux-navigator" },
  -- Highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "0.5-compat",
    run = ":TSUpdate",
    config = function()
      require("plugins.nvim-treesitter").setup()
    end,
  },
  -- A light and configurable statusline/tabline plugin
  { "itchyny/lightline.vim" },
  -- Adds file type icons to Vim plugins such as: NERDTree, lightline, vim-startify...
  { "ryanoasis/vim-devicons" },
  { "kyazdani42/nvim-web-devicons" },
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
  -- Vim plugin for git
  {
    "tpope/vim-fugitive",
    config = function()
      require("plugins.vim-fugitive").setup()
    end,
  },
  -- Show git diff in the sign column
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("plugins.gitsigns").setup()
    end,
  },
  -- Vim easy motion
  {
    "easymotion/vim-easymotion",
    config = function()
      require("plugins.vim-easymotion").setup()
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
    event = "BufRead",
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
  { "editorconfig/editorconfig-vim" },
  -- Modify variable name to snake_case, camelCase, UPPER_CASE...
  {
    "tpope/vim-abolish",
    event = "BufRead",
  },
  -- Define submodes to the built-in vim modes
  {
    "kana/vim-submode",
    config = function()
      require("plugins.vim-submode").setup()
    end,
  },
  -- File in ftplugin/*.lua or after/ftplugin/*.lua will now get automatically run at the correct time
  { "tjdevries/astronauta.nvim" },
  -- LSP client
  { "neovim/nvim-lspconfig" },
  -- Provides the missing :LspInstall for nvim-lspconfig
  {
    "kabouzeid/nvim-lspinstall",
    event = "VimEnter",
    config = function()
      require("lspinstall").setup()
    end,
  },
  -- Setting LSP with json files
  { "tamago324/nlsp-settings.nvim" },
  -- Completion
  {
    "hrsh7th/nvim-compe",
    event = "InsertEnter",
    config = function()
      require("plugins.nvim-compe").setup()
    end,
  },
  -- Autopair
  {
    "windwp/nvim-autopairs",
    after = "nvim-compe",
    config = function()
      require("plugins.nvim-autopairs").setup()
    end,
  },
  -- Snippet
  {
    "hrsh7th/vim-vsnip",
    event = "InsertCharPre",
  },
  -- Set of preconfigured snippets for different languages.
  {
    "rafamadriz/friendly-snippets",
    event = "InsertCharPre",
  },
  -- Comment
  {
    "terrortylor/nvim-comment",
    event = "BufRead",
    config = function()
      require("plugins.nvim-comment").setup()
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
}

return {
  -- Packer can manage itself as an optional plugin
  { "wbthomason/packer.nvim" },
  -- Intellij as language server
  {
    "dinhhuy258/vintellij",
    branch = "lsp",
  },
  -- Vim utilities
  { "dinhhuy258/vim-utilities" },
  -- Local history in vim
  {
    "dinhhuy258/vim-local-history",
    run = ":UpdateRemotePlugins",
  },
  -- Open git repository
  { "dinhhuy258/vim-git-browse" },
  -- Vim database
  { "dinhhuy258/vim-database" },
  -- File explorer
  {
    "dinhhuy258/chadtree",
    run = ":UpdateRemotePlugins",
  },
  -- Color scheme
  { "cocopon/iceberg.vim" },
  -- Seamless navigation between tmux panes and vim splits
  { "christoomey/vim-tmux-navigator" },
  -- Highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function ()
      require("plugins.nvim-treesitter").setup()
    end
  },
  -- A light and configurable statusline/tabline plugin
  { "itchyny/lightline.vim" },
  -- Adds file type icons to Vim plugins such as: NERDTree, lightline, vim-startify...
  { "ryanoasis/vim-devicons" },
  -- Vim plugin for git
  {
    "tpope/vim-fugitive",
    config = function ()
      require("plugins.vim-fugitive").setup()
    end
  },
  -- Show git diff in the sign column
  {
    "airblade/vim-gitgutter",
    event = "BufRead",
    config = function ()
      require("plugins.vim-gitgutter").setup()
    end
  },
  -- Vim easy motion
  {
    "easymotion/vim-easymotion",
    config = function ()
      require("plugins.vim-easymotion").setup()
    end
  },
  -- Vim surround
  { "tpope/vim-surround" },
  -- Enable repeating supported plugins map with .
  { "tpope/vim-repeat" },
  -- Make f, F, t, T more clever
  {
    "rhysd/clever-f.vim",
    config = function ()
      require("plugins.clever-f").setup()
    end
  },
  -- Bufferline
  {
    "mengelbrecht/lightline-bufferline",
    config = function ()
      require("plugins.lightline-bufferline").setup()
    end
  },
  -- The fancy start screen
  {
    "mhinz/vim-startify",
    event = "BufWinEnter",
    config = function()
      require("plugins.vim-startify").setup()
    end
  },
  -- Multi editor tool for defining base file handling and code style preferences
  { "editorconfig/editorconfig-vim" },
  -- Modify variable name to snake_case, camelCase, UPPER_CASE...
  { "tpope/vim-abolish" },
  -- Define submodes to the built-in vim modes
  {
    'kana/vim-submode',
    config = function ()
      require("plugins.vim-submode").setup()
    end
  },
  -- Make FocusGained and FocusLost autocommand events work
  { "tmux-plugins/vim-tmux-focus-events" },
  -- LSP client
  { "neovim/nvim-lspconfig" },
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
    config = function ()
      require("plugins.telescope").setup()
    end
  },
  -- Provides the missing :LspInstall for nvim-lspconfig
  {
    "kabouzeid/nvim-lspinstall",
    event = "VimEnter",
    config = function()
      require"lspinstall".setup()
    end,
  },
  -- Setting LSP with json files
  { "tamago324/nlsp-settings.nvim" },
  -- Completion
  {
    "hrsh7th/nvim-compe",
    event = "InsertEnter",
    config = function ()
      require("plugins.nvim-compe").setup()
    end
  },
  -- Autopair
  {
    "windwp/nvim-autopairs",
    after = "nvim-compe",
    config = function ()
      require("plugins.nvim-autopairs").setup()
    end
  },
}

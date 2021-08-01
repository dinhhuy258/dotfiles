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
  },
  -- A light and configurable statusline/tabline plugin
  { "itchyny/lightline.vim" },
  -- Adds file type icons to Vim plugins such as: NERDTree, lightline, vim-startify...
  { "ryanoasis/vim-devicons" },
  -- Vim plugin for git
  { "tpope/vim-fugitive" },
  -- Show git diff in the sign column
  { "airblade/vim-gitgutter" },
  -- Vim easy motion
  { "easymotion/vim-easymotion" },
  -- Vim surround
  { "tpope/vim-surround" },
  -- Enable repeating supported plugins map with .
  { "tpope/vim-repeat" },
  -- Make f, F, t, T more clever
  { "rhysd/clever-f.vim" },
  -- Bufferline
  { "mengelbrecht/lightline-bufferline" },
  -- The fancy start screen
  { "mhinz/vim-startify" },
  -- Multi editor tool for defining base file handling and code style preferences
  { "editorconfig/editorconfig-vim" },
  -- Modify variable name to snake_case, camelCase, UPPER_CASE...
  { "tpope/vim-abolish" },
  -- Define submodes to the built-in vim modes
  { 'kana/vim-submode' },
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

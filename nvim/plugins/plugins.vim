" Install vimplug if not exists
let vimplug_folder=expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(vimplug_folder)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . vimplug_folder . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Specify a directory for plugins
call plug#begin(expand('~/.config/nvim/plugged'))

" Tree explorer plugin
Plug 'dinhhuy258/chadtree', {'branch': 'master', 'do': ':UpdateRemotePlugins'}
" Seamless navigation between tmux panes and vim splits
Plug 'christoomey/vim-tmux-navigator'
" Color scheme
Plug 'cocopon/iceberg.vim'
" A light and configurable statusline/tabline plugin
Plug 'itchyny/lightline.vim'
" Add file type icons to vim plugins
Plug 'ryanoasis/vim-devicons'
" Show git diff in the sign column
Plug 'airblade/vim-gitgutter'
" Vim plugin for git
Plug 'tpope/vim-fugitive'
" Vim easy motion
Plug 'easymotion/vim-easymotion'
" Vim surround
Plug 'tpope/vim-surround'
" Enable repeating supported plugins map with .
Plug 'tpope/vim-repeat'
" Make f, F, t, T more clever
Plug 'rhysd/clever-f.vim'
" Completion framework
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Asynchronous Lint Engine
Plug 'dense-analysis/ale'
" Use fzf instead of coc.nvim built-in fuzzy finder
Plug 'antoinemadec/coc-fzf'
" Use nvim's builtin terminal in the floating/popup window
Plug 'voldikss/vim-floaterm'
" Bufferline
Plug 'mengelbrecht/lightline-bufferline'
" The fancy start screen
Plug 'mhinz/vim-startify'
" Better syntax support
Plug 'sheerun/vim-polyglot'
" Multi editor tool for defining base file handling and code style preferences
Plug 'editorconfig/editorconfig-vim'
" Define submodes to the built-in vim modes
Plug 'kana/vim-submode'
" Make FocusGained and FocusLost autocommand events work
Plug 'tmux-plugins/vim-tmux-focus-events'
" Intellij as language server
Plug 'dinhhuy258/vintellij', {'branch': 'comrade'}
" Vim utilities
Plug 'dinhhuy258/vim-utilities'
" Local history in vim
Plug 'dinhhuy258/vim-local-history', {'branch': 'master', 'do': ':UpdateRemotePlugins'}
" Open git repository
Plug 'dinhhuy258/vim-git-browse'
" Vim database
Plug 'dinhhuy258/vim-database'
" fzf
if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif

" Initialize plugin system
call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif


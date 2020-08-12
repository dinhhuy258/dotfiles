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
Plug 'scrooloose/nerdtree'
" Showing git status in NERDTree
Plug 'Xuyuanp/nerdtree-git-plugin'
" Seamless navigation between tmux panes and vim splits
Plug 'christoomey/vim-tmux-navigator'
" Color scheme
Plug 'cocopon/iceberg.vim'
Plug 'gkeep/iceberg-dark'
" A light and configurable statusline/tabline plugin
Plug 'itchyny/lightline.vim'
" Add file type icons to vim plugins
Plug 'ryanoasis/vim-devicons'
" Show git diff in the sign column
Plug 'airblade/vim-gitgutter'
" Vim plugin for git
Plug 'tpope/vim-fugitive'
" Github extension for fugitive.vim
Plug 'tpope/vim-rhubarb'
" Vim easy motion
Plug 'easymotion/vim-easymotion'
" Vim surround
Plug 'tpope/vim-surround'
" Enable repeating supported plugins map with .
Plug 'tpope/vim-repeat'
" Automatically closing braces
Plug 'jiangmiao/auto-pairs'
" Convenience for commenting things in and out
Plug 'scrooloose/nerdcommenter'
" Make the yarn region apparent
Plug 'machakann/vim-highlightedyank'
" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
" Underlines the word under the cursor
Plug 'itchyny/vim-cursorword'
" Intellij as language server
Plug 'dinhhuy258/vintellij'
" Vim utilities
Plug 'dinhhuy258/vim-utilities'
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


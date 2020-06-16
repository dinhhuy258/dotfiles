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
" Seamless navigation between tmux panes and vim splits
Plug 'christoomey/vim-tmux-navigator'
" Color scheme
Plug 'christianchiarulli/onedark.vim'
" Lean & mean status/tabline
Plug 'vim-airline/vim-airline'
" Show git diff in the sign column
Plug 'airblade/vim-gitgutter'
" Stop repeating the basic movement keys
Plug 'takac/vim-hardtime'
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
" Show keybindings in popup
Plug 'liuchengxu/vim-which-key'
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


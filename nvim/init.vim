"*****************************************************************************
" Plugins
"*****************************************************************************

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

Plug 'scrooloose/nerdtree'

" Initialize plugin system
call plug#end()
"*****************************************************************************
" Basic Setup
"*****************************************************************************"

" Change leader key to space
let mapleader = "\<Space>"

" Shell
if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" Fix backspace indent
set backspace=indent,eol,start

" Tabs
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

"*****************************************************************************
" Visual Settings
"*****************************************************************************

syntax on

" Display line numbers
set number
set numberwidth=5
set relativenumber

"*****************************************************************************
" Mappings
"*****************************************************************************

" Split
noremap <Leader>- :<C-u>split<CR>
noremap <Leader>\ :<C-u>vsplit<CR>


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

" Tree explorer plugin
Plug 'scrooloose/nerdtree'
" Seamless navigation between tmux panes and vim splits
Plug 'christoomey/vim-tmux-navigator'
" Color scheme
Plug 'tomasr/molokai'
" Show git diff in the sign column
Plug 'airblade/vim-gitgutter'
" Lean & mean status/tabline
Plug 'vim-airline/vim-airline'
" Collection of themes for vim-airline
Plug 'vim-airline/vim-airline-themes'
" Stop repeating the basic movement keys
Plug 'takac/vim-hardtime'
" Vim easy motion
Plug 'easymotion/vim-easymotion'
" Vim surround
Plug 'tpope/vim-surround'
" Enable repeating supported plugins map with .
Plug 'tpope/vim-repeat'
" fzf
if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif

" Initialize plugin system
call plug#end()

"*****************************************************************************
" Basic Setup
"*****************************************************************************

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

" Stop line breaking
set nowrap

" Minimal number of screen lines to keep above and below the cursor
set scrolloff=3

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"*****************************************************************************
" Visual Settings
"*****************************************************************************

" Color Scheme
let g:molokai_original = 1
colorscheme molokai

" Syntax highlighting
syntax on

" Display line numbers
set number
set numberwidth=5
set relativenumber

" Show the cursor position
set ruler

" Always show status bar (2 = always)
set laststatus=2
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

" Display hidden characters
set listchars=tab:▸\ ,eol:¬
set list

"*****************************************************************************
" Mappings
"*****************************************************************************

" Reload vim configuration
nnoremap <Leader>r :so %<cr>

" Split
noremap <Leader>- :<C-u>split<CR>
noremap <Leader>\ :<C-u>vsplit<CR>

" Toggle nerdtree
nnoremap <silent> <F1> :NERDTreeToggle<CR>

" Clean search (highlight)
nnoremap <silent> <Leader><space> :noh<CR>

" All easymotion will be triggered with ; key
map ; <Plug>(easymotion-prefix)

" fzf
nnoremap <silent> <Leader>f :FZF -m<CR>
nnoremap <silent> <leader>b :Buffers<CR>

"*****************************************************************************
" Commands
"*****************************************************************************

" Remove trailing whitespaces
command! FixWhitespace :%s/\s\+$//e

"*****************************************************************************
" Plugin configs
"*****************************************************************************

" Vim airline
let g:airline_theme = 'powerlineish'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

let g:airline#extensions#virtualenv#enabled = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif

" GitGutter
highlight clear SignColumn
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=yellow
highlight GitGutterDelete ctermfg=red
highlight GitGutterChangeDelete ctermfg=yellow

" Nerdtree
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" Vim hardtime
" Run vim hardtime on every buffer
let g:hardtime_default_on = 1
" Enable the nofication about hardtime being enabled set
let g:hardtime_showmsg = 1
" Tell hardtime ignore certain buffer pattern set
let g:hardtime_ignore_buffer_patterns = [ "CustomPatt[ae]rn", "NERD.*" ]
let g:hardtime_ignore_quickfix = 1
let g:hardtime_maxcount = 5

" Vim easymotion
" Enable default mappings
let g:EasyMotion_do_mapping = 1
" Turn on case-sensitive feature
let g:EasyMotion_smartcase = 1

" fzf
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"


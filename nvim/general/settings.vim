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

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Tab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Indent
set smartindent
set autoindent

" Display long lines as just one line
set nowrap

" Minimal number of screen lines to keep above and below the cursor
set scrolloff=3

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Enables syntax highlighting
syntax on

" Display line numbers
set number
set numberwidth=4
set relativenumber

" Show the cursor position
set ruler

" Always show status bar (2 = always)
set laststatus=2
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

" Display hidden characters
set listchars=tab:▸\ ,eol:¬
set list

" Required to keep multiple buffers open multiple buffers
set hidden

" Some LSP servers have issues with backup files
set nobackup
set nowritebackup

" Giving more spaces for displaying messages
set cmdheight=2

" Faster completion
set updatetime=300

" Time in milliseconds to wait for a mapped sequence to complete
set timeoutlen=1000

" Don't pass messages to |ins-completion-menu|
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved.
set signcolumn=yes

" Stop newline continution of comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Treat dash separated words as a word text object
set iskeyword+=-

" Tell vim what the background color looks like
set background=dark

" We don't need the see things like -- INSERT -- anymore
set noshowmode

" Always show tabs (2 = always)
set showtabline=2

" Horizontal splits will automatically be below
set splitbelow

" Vertical splits will automatically be to the right
set splitright

" Copy paste between vim and everything else
set clipboard=unnamedplus

" Setting the font in the GUI 
set guifont=Hack\ Nerd\ Font

" Support 256 colors
set t_Co=256

" Enable mouse
set mouse=a


"    ____      _ __        _
"   /  _/___  (_) /__   __(_)___ ___
"   / // __ \/ / __/ | / / / __ `__ \
" _/ // / / / / /__| |/ / / / / / / /
"/___/_/ /_/_/\__(_)___/_/_/ /_/ /_/

" " fzf
" if isdirectory('/usr/local/opt/fzf')
"   Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
" else
"   Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
"   Plug 'junegunn/fzf.vim'
" endif

" " Initialize plugin system
" call plug#end()

" " Automatically install missing plugins on startup
" autocmd VimEnter *
"   \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
"   \|   PlugInstall --sync | q
"   \| endif

lua require 'init'


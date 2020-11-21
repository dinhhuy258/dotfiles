"    ____      _ __        _
"   /  _/___  (_) /__   __(_)___ ___
"   / // __ \/ / __/ | / / / __ `__ \
" _/ // / / / / /__| |/ / / / / / / /
"/___/_/ /_/_/\__(_)___/_/_/ /_/ /_/

source $HOME/.config/nvim/plugins/plugins.vim

source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/general/mappings.vim

lua require 'init'
source $HOME/.config/nvim/themes/lightline.vim

lua require 'plugins.treesitter'

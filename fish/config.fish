source ~/.config/fish/env.fish

source $DOTFILES/fish/tokyonight_night.fish

source $DOTFILES/fish/kubectl_aliases.fish
source $DOTFILES/fish/git_aliases.fish

source $DOTFILES/fish/functions/greeting.fish
source $DOTFILES/fish/functions/fzf.fish
source $DOTFILES/fish/functions/docker.fish
source $DOTFILES/fish/functions/kubectl.fish

eval (/opt/homebrew/bin/brew shellenv)

set -x EDITOR nvim
set -x VISUAL nvim
set -x LANG en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8
set -x LC_ALL en_US.UTF-8

# bind control + v to edit_command_buffer
bind \cv edit_command_buffer
bind \cw 'fzf_worskpace; commandline -f repaint'

if not set -q TMUX
  set -g TMUX tmux new-session -d -s base
  eval $TMUX
  tmux attach-session -d -t base
end

alias vim=nvim
alias vi=nvim
alias lg=lazygit

starship init fish | source

set -g fish_greeting
eval greeting

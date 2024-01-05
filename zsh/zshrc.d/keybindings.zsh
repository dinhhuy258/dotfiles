#!/bin/zsh

autoload -z edit-command-line
zle -N edit-command-line
bindkey '^v' edit-command-line

zle -N fprj
bindkey '^ ' fprj

zle -N fpass
bindkey '^p' fpass

# see `man bash` to define more key bindings
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
bindkey "^i" kill-line
bindkey "^y" kill-whole-line

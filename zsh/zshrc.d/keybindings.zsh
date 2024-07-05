#!/bin/zsh

autoload -z edit-command-line
zle -N edit-command-line
bindkey '^v' edit-command-line

zle -N fprj
bindkey '^ ' fprj

# see `man bash` to define more key bindings
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
bindkey "^i" kill-line
bindkey "^y" kill-whole-line

bindkey '\t' complete-word

# navi
eval "$(navi widget zsh)"
bindkey "^g" navi_widget

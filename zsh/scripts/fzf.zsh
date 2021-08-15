#!/bin/zsh

# Open fzf in tmux popup
function __fzfp() {
  fzf-tmux -p -w 70% -h 70%
}

# Open project under workspace folder
function fprj() {
  cd $WORKSPACE; ls -d */ | __fzfp | {
    cd -;
    read result;
    if [ ! -z "$result" ]; then
      cd $WORKSPACE/$result
    fi
  }
  zle && zle reset-prompt
}

# Run frequently used commands
# First param take local path to set of commands, i.e. ~/local/cmds
function fcmd() {
  echo $1
  local cmd=$(cat $1 | ${2-"__fzfp"})
  if [ -n "$cmd" ]; then
    local escape=$(echo $cmd | sed 's/[]\/$*.^[]/\\&/g')
    echo -e "$cmd\n$(cat $1 | sed "s/$escape//g" | sed '/^$/d')" > $1
    echo ""
    echo $fg[yellow] "$cmd"
    echo ""
    eval $cmd
  else
    echo $fg[red] "Run nothing!"
  fi
}


# Lauch application
function fapp() {
  local app=$((ls /Applications; ls /System/Applications/; ls /System/Applications/Utilities) | cat | sed 's/.app//g' | fzf)
  open -a $app
}

# Close application
function fkill() {
  select_app=$(osascript -e 'tell application "System Events" to get name of (processes where background only is false)' | awk -F ', ' '{for(i=1;i<=NF;i++) printf "%s\n", $i}'  | fzf)
  if [ -n "$select_app" ]; then
    printf "${bold}Do you want to kill ${select_app}? (y/n)${reset}\n"
    read
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      pkill -x "${select_app}"
    fi
  fi
}

# Select password using fzf
function fpass() {
  local prompt='Search password: '
  local fzf_cmd="${1-"__fzfp"} --print-query --prompt=\"$prompt\""

  if [ -n "$term" ]; then
    fzf_cmd="$fzf_cmd -q\"$term\""
  fi

  fzf_cmd="$fzf_cmd | tail -n1"

  if [ ! -d $HOME/.password-store ]; then
    e_error "Could not locate password store directory. Please ensure $HOME/.password-store is setup."
    return
  fi

  passfile=$(find -L "$HOME/.password-store" -path '*/.git' -prune -o -iname '*.gpg' -print \
        | sed -e 's/.gpg$//' | sed -e 's/\/Users\/'$(whoami)'\/.password-store\///' \
        | sort \
        | eval "$fzf_cmd" )

  if [ -z "$passfile" ]; then
    e_warning 'No passfile selected.'
    return
  fi

  pass show "$passfile" --clip || return
}


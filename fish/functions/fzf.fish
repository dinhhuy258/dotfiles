#!/usr/bin/env fish

function __fzfp
  fzf-tmux -p -w 70% -h 70%
end

function fzf_worskpace -d "Select workspace"
  ls $WORKSPACE | tr " " "\n" | __fzfp | read result

  if test -z $result
    echo (set_color yellow)"No project selected."(set_color normal)

    return
  end

  cd $WORKSPACE/$result
  echo "cd $WORKSPACE/$result"
end

function fzf_cmd -d "Run command from provided file. Usage: fzf_cmd <file>"
  set cmd (cat $argv[1] | __fzfp)
  if test -n "$cmd"
    eval $cmd
  else
    echo (set_color yellow)"Run nothing!"(set_color normal)
  end
end

function fzf_pass -d "Select password from pass"
  set fzf_cmd fzf-tmux --print-query --prompt='Password: ' | tail -n1

  set passfile (find -L "$HOME/.password-store" -path '*/.git' -prune -o -iname '*.gpg' -print \
        | sed -e 's/.gpg$//' | sed -e 's/\/Users\/'$(whoami)'\/.password-store\///' \
        | sort \
        | eval "$fzf_cmd" )

  if test -z "$passfile"
    echo (set_color yellow)"No password selected."(set_color normal)

    return
  end

  eval "pass show $passfile --clip || return"
end

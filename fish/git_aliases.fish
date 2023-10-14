#!/usr/bin/env fish

alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gst='git status'
alias gcmsg='git commit -m'
alias gcl='git clone --recurse-submodules'
alias gr='git remote'
alias gfo='git fetch origin'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcm='git checkout (git_main_branch)'
alias gcd='git checkout (git_develop_branch)'
alias ggpush='git push origin (git_current_branch)'
alias ggpull='git pull origin (git_current_branch)'
alias gstall='git stash --all'
alias gstaa='git stash apply'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gbD='git branch --delete --force'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'

function git_current_branch
  set -l ref (command git symbolic-ref --quiet HEAD 2> /dev/null)
  set -l ret $status
  if test $ret -ne 0
    if test $ret -eq 128
      return
    end
    set ref (command git rev-parse --short HEAD 2> /dev/null); or return
  end

  echo $ref | sed "s#^refs/heads/##"
end

function git_develop_branch
  command git rev-parse --git-dir > /dev/null 2>&1; and or return

  for branch in dev devel development
    if command git show-ref -q --verify refs/heads/$branch
      echo $branch
      return
    end
  end

  echo develop
end

function git_main_branch
  command git rev-parse --git-dir > /dev/null 2>&1; and or return

  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default}
    if command git show-ref -q --verify $ref
      echo (basename $ref)
      return
    end
  end

  echo master
end

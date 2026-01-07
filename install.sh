#!/usr/bin/env bash

DOTFILES=$(pwd -P)

set -e

echo ''

info() {
  printf "\r  [ \033[00;34m..\033[0m ] %s\n" "$1"
}

user() {
  printf "\r  [ \033[0;33m??\033[0m ] %s\n" "$1"
}

success() {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] %s\n" "$1"
}

fail() {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] %s\n" "$1"
  echo ''
  exit
}

link_file() {
  local src=$1 dst=$2

  local overwrite=
  local backup=
  local skip=
  local action=

  if [ -f "$dst" ] || [ -d "$dst" ] || [ -L "$dst" ]; then

    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]; then

      # ignoring exit 1 from readlink in case where file already exists
      # shellcheck disable=SC2155
      local currentSrc="$(readlink "$dst")"

      if [ "$currentSrc" == "$src" ]; then

        skip=true

      else

        user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action </dev/tty

        case "$action" in
        o)
          overwrite=true
          ;;
        O)
          overwrite_all=true
          ;;
        b)
          backup=true
          ;;
        B)
          backup_all=true
          ;;
        s)
          skip=true
          ;;
        S)
          skip_all=true
          ;;
        *) ;;
        esac

      fi

    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]; then
      rm -rf "$dst"
      success "removed $dst"
    fi

    if [ "$backup" == "true" ]; then
      mv "$dst" "${dst}.backup"
      success "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]; then
      success "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]; then # "false" or empty
    ln -s "$1" "$2"
    success "linked $1 to $2"
  fi
}

install_homebrew() {
  if ! which brew >/dev/null; then
    info "Installing homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  else
    info "Updating homebrew"
    brew update
    brew upgrade
  fi

  info "Installing homebrew packages"
  brew bundle --file "$DOTFILES/brew/Brewfile"
}

install_zsh() {
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    info "Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi

  if [ ! -f "$HOME/.oh-my-zsh/antigen.zsh" ]; then
    info "Installing antigen"
    curl -L git.io/antigen >"$HOME/.oh-my-zsh/antigen.zsh"
  fi
}

install_tmux_plugin_manager() {
  if [ ! -d "$HOME/.tmux/plugins" ]; then
    info "Installing tmux plugin manager"
    mkdir -p "$HOME/.tmux/plugins"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi
}

install_dotfiles() {
  info 'Installing dotfiles'

  local overwrite_all=false backup_all=false skip_all=false

  mkdir -p "$HOME/.config"

  # nvim
  mkdir -p "$HOME/.config/nvim"
  link_file "$DOTFILES/nvim" "$HOME/.config/nvim"

  # alacritty
  link_file "$DOTFILES/alacritty/alacritty.toml" "$HOME/.config/alacritty.toml"
  link_file "$DOTFILES/alacritty/alacritty-popup.yml" "$HOME/.config/alacritty-popup.yml"

  # tmux
  link_file "$DOTFILES/tmux/tmux.conf" "$HOME/.tmux.conf"

  # zsh
  link_file "$DOTFILES/zsh/zshrc" "$HOME/.zshrc"

  # karabiner
  link_file "$DOTFILES/karabiner/karabiner.edn" "$HOME/.config/karabiner.edn"

  # aerospace
  mkdir -p "$HOME/.config/aerospace"
  link_file "$DOTFILES/aerospace/aerospace.toml" "$HOME/.config/aerospace/aerospace.toml"
  link_file "$DOTFILES/aerospace/notification.sh" "$HOME/.config/aerospace/notification.sh"

  # borders
  mkdir -p "$HOME/.config/borders"
  link_file "$DOTFILES/borders/bordersrc" "$HOME/.config/borders/bordersrc"

  # starship
  link_file "$DOTFILES/starship/starship.toml" "$HOME/.config/starship.toml"

  # neofetch
  mkdir -p "$HOME/.config/neofetch"
  link_file "$DOTFILES/neofetch/config.conf" "$HOME/.config/neofetch/config.conf"

  # sketchybar
  link_file "$DOTFILES/sketchybar" "$HOME/.config/sketchybar"

  # taskwarrior
  mkdir -p "$HOME/.config/task"
  link_file "$DOTFILES/task/taskrc" "$HOME/.config/task/taskrc"

  # git
  link_file "$DOTFILES/git/gitconfig" "$HOME/.gitconfig"
  link_file "$DOTFILES/git/gitignore" "$HOME/.gitignore"

  # navi
  link_file "$DOTFILES/navi" "$HOME/.config/navi"

  # mise
  link_file "$DOTFILES/mise/config.toml" "$HOME/.config/mise/config.toml"

  # fm
  link_file "$DOTFILES/fm/config.lua" "$HOME/.config/fm/config.lua"

  # warpd
  link_file "$DOTFILES/warpd/config" "$HOME/.config/warpd/config"

  # snipaste
  mkdir -p "$HOME/.snipaste"
  link_file "$DOTFILES/snipaste/config.ini" "$HOME/.snipaste/config.ini"

  # AI
  link_file "$DOTFILES/ai/mcp.json" "$HOME/.config/mcphub/mcp.json"
  link_file "$DOTFILES/ai/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
  link_file "$DOTFILES/ai/commands/gemini/commit.toml" "$HOME/.gemini/commands/commit.toml"
  link_file "$DOTFILES/ai/commands/gemini/review.toml" "$HOME/.gemini/commands/review.toml"

  # docker
  link_file "$DOTFILES/docker/config.json" "$HOME/.docker/config.json"
}

create_cmds_file() {
  info "Creating cmds file"

  touch "$HOME/.cmds"
  {
    echo 'say "test speaker"'
    echo 'calcurse'
    echo 'ping google.com'
    echo 'nvim -u NONE ~/.cmds'
    echo 'brew services restart sketchybar'
  } >"$HOME/.cmds"
}

install_zsh
install_tmux_plugin_manager
install_dotfiles
create_cmds_file
install_homebrew

success 'All installed!'

# brew services start borders
# brew services start sketchybar
# brew services start colima
# go install github.com/dinhhuy258/fm@latest
# curl -L https://github.com/rvaiya/warpd/releases/download/v1.3.5/warpd-1.3.5-osx.tar.gz |  sudo tar xzvfC - / && launchctl load /Library/LaunchAgents/com.warpd.warpd.plist

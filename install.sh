#!/bin/bash

CWD=$(pwd)

function installHomebrewCaskPackage() {
  if brew list --cask | grep $1 > /dev/null; then
    echo "$1 is already installed"
  else
    echo "Installing $1..."
    brew install --cask $1
  fi
}

function installHomebrewPackage() {
  if brew list | grep $1 > /dev/null; then
    echo "$1 is already installed"
  else
    echo "Installing $1..."
    brew install $1
  fi
}

# Init and update git submodules
echo "Init and update git submodules..."
git submodule update --init --recursive

# Install homebrew
if ! which brew >/dev/null; then
  read -p "Install brew? (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Installing brew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi
fi

# Install homebrew packages
if which brew >/dev/null; then
  read -p "Install homebrew packages? (y/n) " -n 1
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Installing homebrew packages..."
    installHomebrewCaskPackage alacritty
    installHomebrewCaskPackage karabiner-elements
    installHomebrewCaskPackage raycast
    brew tap homebrew/cask-fonts
    installHomebrewCaskPackage font-fira-code-nerd-font
    installHomebrewPackage neovim
    installHomebrewPackage tmux
    installHomebrewPackage fzf
    installHomebrewPackage ripgrep
    installHomebrewPackage fd
    installHomebrewPackage node
    installHomebrewPackage lazygit
    installHomebrewPackage urlview
    installHomebrewPackage tldr
    installHomebrewPackage pass
    installHomebrewPackage jq
    installHomebrewPackage lnav
    installHomebrewPackage go
    installHomebrewPackage task
    installHomebrewPackage derailed/k9s/k9s
    installHomebrewPackage koekeishiya/formulae/skhd
    installHomebrewPackage koekeishiya/formulae/yabai
    installHomebrewPackage starship
    installHomebrewPackage neofetch
    brew tap FelixKratz/formulae
    installHomebrewPackage sketchybar

    # Greeting message
    installHomebrewPackage cowsay
    installHomebrewPackage lolcat
  fi
else
  echo "Homebrew not installed! Skipping package installation..."
fi

# Install zsh
read -p "Install zsh? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "Installing zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  echo "Installing antigen..."
  curl -L git.io/antigen > $HOME/.oh-my-zsh/antigen.zsh
fi

# Install tmux plugins
read -p "Install tmux plugins? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "Installing tmux plugins..."
  mkdir -p ~/.tmux/plugins
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi;

# Sync folders
read -p "Sync folders? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "Syncing folders..."
  # Sync nvim
  mkdir -p ~/.config
  rm -rf ~/.config/nvim
  ln -sf $CWD/nvim ~/.config/nvim

  # Sync alacritty
  ln -sf $CWD/alacritty/alacritty.yml ~/.config/alacritty.yml
  ln -sf $CWD/alacritty/alacritty-popup.yml ~/.config/alacritty-popup.yml

  # Sync tmux
  ln -sf $CWD/tmux/tmux.conf ~/.tmux.conf

  # Sync zsh
  ln -sf $CWD/zsh/zshrc.local ~/.zshrc.local
  ln -sf $CWD/zsh/zshrc ~/.zshrc

  # Sync karabiner config
  mkdir -p ~/.config/karabiner
  ln -sf $CWD/karabiner/karabiner.json ~/.config/karabiner/karabiner.json

  # Sync yabai config
  mkdir -p ~/.config/yabai
  ln -sf $CWD/yabai/yabairc ~/.config/yabai/yabairc

  # Sync skhd config
  mkdir -p ~/.config/skhd
  ln -sf $CWD/skhd/skhdrc ~/.config/skhd/skhdrc

  # Sync cmds
  ln -sf $CWD/zsh/cmds ~/.cmds

  # Sync starship
  mkdir -p ~/.config/starship
  ln -sf $CWD/starship/starship.toml ~/.config/starship.toml

  # Sync neofetch
  mkdir -p ~/.config/neofetch
  ln -sf $CWD/neofetch/config.conf ~/.config/neofetch/config.conf

  # Sync sketchybar config
  ln -sf $CWD/sketchybar ~/.config/sketchybar

  # Sync task config
  mkdir -p ~/.config/task
  ln -sf $CWD/task/taskrc ~/.config/task/taskrc
fi

# brew services start skhd
# brew services start yabai
# brew services start sketchybar
# brew services start svim

# go install github.com/dinhhuy258/fm@latest

echo "All done!"


#!/bin/bash

CWD=$(pwd)

function installHomebrewCaskPackage() {
  if brew cask list | grep $1 > /dev/null; then
    echo "$1 is already installed"
  else
    echo "Installing $1..."
    brew cask install $1
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
    installHomebrewCaskPackage kitty
    installHomebrewCaskPackage karabiner-elements
    brew tap homebrew/cask-fonts
    installHomebrewCaskPackage font-fira-code-nerd-font
    installHomebrewPackage neovim
    installHomebrewPackage tmux
    installHomebrewPackage fzf
    installHomebrewPackage rg
    installHomebrewPackage node
    installHomebrewPackage lazygit
    installHomebrewPackage urlview
    installHomebrewPackage ranger

    # Greeting message
    installHomebrewPackage cowsay
    installHomebrewPackage lolcat

    # installHomebrewPackage llvm 
    # installHomebrewPackage pylint
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

read -p "Install skhd? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
  if brew list | grep skhd > /dev/null; then
    echo "skhd is already installed"
  else
    echo "Installing skhd..."
    brew install koekeishiya/formulae/skhd
    brew services start skhd
  fi

  # Sync skhd config
  ln -sf $CWD/skhd/skhdrc ~/.skhdrc
fi

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

  # Sync ranger
  rm -rf ~/.config/ranger
  ln -sf $CWD/ranger ~/.config/ranger

  # Sync kitty
  rm -rf ~/.config/kitty
  ln -sf $CWD/kitty ~/.config/kitty
fi

echo "All done!"


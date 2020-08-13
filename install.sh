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

# XCode
if which xcode-select >/dev/null; then
  read -p "Install xcode command line tools? (y/n) " -n 1
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Running installer.."
    xcode-select --install
  fi
fi

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
    brew tap homebrew/cask-fonts
    installHomebrewCaskPackage font-fira-code-nerd-font
    installHomebrewPackage neovim
    installHomebrewPackage tmux
    installHomebrewPackage fzf
    installHomebrewPackage rg
    installHomebrewPackage node
    installHomebrewPackage lazygit
    installHomebrewPackage urlview
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

  # Sync tmux
  ln -sf $CWD/tmux/tmux.conf ~/.tmux.conf

  # Sync zsh
  ln -sf $CWD/zsh/zshrc.local ~/.zshrc.local
  ln -sf $CWD/zsh/zshrc ~/.zshrc
  rm -rf ~/.oh-my-zsh/custom/plugins
  ln -sf $CWD/zsh/plugins ~/.oh-my-zsh/custom/plugins
fi

echo "All done!"


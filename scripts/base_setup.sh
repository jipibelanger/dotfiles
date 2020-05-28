#!/bin/bash


# setup home directory structure
echo "Setting up home directory"
mkdir -pv "${HOME}/workspaces" "${HOME}/.config"

# symbolic links
echo "Linking dotfiles"
ln -s "${HOME}/dotfiles/zshrc" "${HOME}/.zshrc"
ln -s "${HOME}/dotfiles/p10k.zsh" "${HOME}/.p10k.zsh"
ln -s "${HOME}/dotfiles/tmux.conf" "${HOME}/.tmux.conf"
ln -s "${HOME}/dotfiles/configs/nvim" "${HOME}/.config/"
ln -s "${HOME}/dotfiles/configs/git" "${HOME}/.config/"

# generate ssh keys
if [[ ! -f "${HOME}/.ssh/id_rsa" ]]; then
  ssh-keygen -C "jp@$(uname -n)"
fi

# install base packages
echo "Installing base dependencies"
if [[ "${OSTYPE}" == "linux-gnu"* ]]; then
  echo "Installing for ${OSTYPE}"
  sudo apt-get update && sudo apt-get upgrade
  sudo apt-get install -y --no-install-recommends \
    build-essential curl file git zsh
elif [[ "${OSTYPE}" == "darwin"* ]]; then
  echo "Installing for ${OSTYPE}"
  xcode-select --install
else
  "No base packages list to install for OS: ${OSTYPE}. Aborting."
  exit 1
fi

# ZSH setup
if [[ -x "$(command -v zsh)" ]]; then
  echo "Setting up ZSH"
  if [[ "${SHELL}" != *"zsh" ]]; then
    chsh -s $(command -v zsh);
  fi
  if [[ ! -d "${HOME}/.zinit/" ]]; then
    # install zinit
    echo "Installing zinit"
    mkdir -p "${HOME}/.zinit/"
    git clone https://github.com/zdharma/zinit.git ~/.zinit/bin
  fi
fi

# install Homebrew
if [[ ! -x "$(command -v brew)" ]]; then
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  if [[ "${OSTYPE}" == "linux-gnu"* ]]; then
    test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
    test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    test -r ~/.zprofile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.zprofile
    echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.zprofile
  fi
fi

# install packages, stop if Homebrew is not found
if [[ ! -x "$(command -v brew)" ]]; then
  echo "Homebrew not found. Aborting."
  exit 1
fi

# install packages
echo "Installing packages"
brew update
brew install gcc tmux

# setup editor
echo "Installing neovim"
brew install neovim
if [[ ! -d "${HOME}/.cache/dein/" ]]; then
  echo "Installing dein.vim plugin manager"
  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > "${HOME}/dein_installer.sh"
  sh "${HOME}/dein_installer.sh" "${HOME}/.cache/dein"
  rm -f "${HOME}/dein_installer.sh"
fi

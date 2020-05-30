#!/bin/bash


UBUNTU_PKGS="build-essential zsh tmux"
MACOS_PKGS="gcc zsh tmux"

# setup home directory structure
command mkdir -pv "${HOME}/workspaces" "${HOME}/.config"

# symbolic links
ln -s "${HOME}/dotfiles/zshrc" "${HOME}/.zshrc"
ln -s "${HOME}/dotfiles/p10k.zsh" "${HOME}/.p10k.zsh"
ln -s "${HOME}/dotfiles/tmux.conf" "${HOME}/.tmux.conf"
ln -s "${HOME}/dotfiles/configs/nvim" "${HOME}/.config/"
ln -s "${HOME}/dotfiles/configs/git" "${HOME}/.config/"

# generate ssh keys
echo "Generating jp@$(uname -n) SSH identity. Press Enter 3 times."
if [[ ! -f "${HOME}/.ssh/id_rsa" ]]; then
  ssh-keygen -C "jp@$(uname -n)"
fi

# install base packages
echo "Installing base packages"
if [[ "${OSTYPE}" == "linux-gnu"* ]]; then
  echo "Installing for ${OSTYPE}"
  sudo apt-get update && sudo apt-get upgrade
  sudo apt-get install -y --no-install-recommends "${UBUNTU_PKGS}"
elif [[ "${OSTYPE}" == "darwin"* ]]; then
  echo "Installing for ${OSTYPE}"
  xcode-select --install
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.zprofile
  brew install "${MACOS_PKGS}"
fi

# make ZSH the default shell
if [[ -x "$(command -v zsh)" ]]; then
  echo "Setting up ZSH"
  if [[ "${SHELL}" != *"zsh" ]]; then
    chsh -s $(command -v zsh);
  fi
fi

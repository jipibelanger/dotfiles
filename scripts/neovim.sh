#!/bin/bash


install() {
  _install_requirements
  _build
  install_dein
}

uninstall() {
  echo -e "\nUninstalling Neovim"
  sudo rm -f /usr/local/bin/nvim
  sudo rm -rf /usr/local/share/nvim/
  sudo rm -rf $HOME/.cache/dein
}

install_dein() {
  echo "Installing dein.vim plugin manager"
  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > $HOME/dein_installer.sh
  sh $HOME/dein_installer.sh $HOME/.cache/dein
  rm -f $HOME/dein_installer.sh
}

_install_requirements() {
  echo -e "\nInstalling build requirements"
  sudo apt-get update && sudo apt-get install -y --no-install-recommends \
    ninja-build \
    gettext libtool \
    libtool-bin \
    autoconf \
    automake \
    cmake \
    g++ \
    pkg-config \
    unzip
}

_build() {
  echo -e "\nBuilding Neovim from source"
  REPODIR=$HOME/neovim_repo
  git clone https://github.com/neovim/neovim.git $REPODIR
  cd $REPODIR
  make CMAKE_BUILD_TYPE="Release" CMAKE_INSTALL_PREFIX="/usr/local/"
  sudo make install
  rm -rf $REPODIR
}

if declare -f "$1" > /dev/null
then
  "$@"
else
  echo "'$1' is not a known command name" >&2
  echo "Accepted commands: 'install', 'uninstall', 'install_dein'" >&2
  exit 1
fi

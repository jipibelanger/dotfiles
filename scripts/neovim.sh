#!/bin/bash


if [[ ! -x "$(command -v nvim)" ]]; then
  # install build dependencies
  echo "Installing build requirements"
  sudo apt-get update && sudo apt-get install -y --no-install-recommends \
    ninja-build gettext libtool libtool-bin autoconf automake cmake \
    g++ pkg-config unzip
  # build and install neovim
  REPODIR="${HOME}/.neovim_repo"
  git clone https://github.com/neovim/neovim.git ${REPODIR}
  cd ${REPODIR}
  make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=/usr/local/
  sudo make install
  rm -rf ${REPODIR}
  # install dein
  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > "${HOME}/dein_installer.sh"
  sh "${HOME}/dein_installer.sh" "${HOME}/.cache/dein"
  rm -f "${HOME}/dein_installer.sh"
else
  # uninstall if found
  echo "Uninstalling Neovim"
  sudo rm -f /usr/local/bin/nvim
  sudo rm -rf /usr/local/share/nvim/
fi

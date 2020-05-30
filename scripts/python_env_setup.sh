#!/bin/bash


echo "Installing pyenv build environment"
if [[ "${OSTYPE}" == "linux-gnu"* ]]; then
  sudo apt-get install --no-install-recommends \
    make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
    libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev \
    libxmlsec1-dev libffi-dev liblzma-dev
elif [[ "${OSTYPE}" == "darwin"* ]]; then
  brew install openssl readline sqlite3 xz zlib
fi

# setup pyenv
echo "Installing python environment"
brew install pyenv
brew install pyenv-virtualenv

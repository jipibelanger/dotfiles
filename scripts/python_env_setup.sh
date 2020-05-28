#!/bin/bash


echo "Installing pyenv build environment"
sudo apt-get install --no-install-recommends \
  make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
  libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev \
  libxmlsec1-dev libffi-dev liblzma-dev

# setup pyenv
echo "Installing python environment"
brew install pyenv
brew install pyenv-virtualenv

# setup base python interpreter version
echo "Recent versions of Python3 available:"
pyenv install --list | grep "[[:space:]]3." | tail -n20
echo "Versions currently installed:"
pyenv versions
read -p "Python version to install: " PYVERSION
pyenv install "${PYVERSION}"

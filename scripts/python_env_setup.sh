#!/bin/bash


BASE_PKGS="ipython neovim line_profiler jedi flake8"
BASE_VENV_NAME="base"


# install python + pyenv build environment
echo "Installing pyenv build environment"
if [[ "${OSTYPE}" == "linux-gnu"* ]]; then
  sudo apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
    libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git
elif [[ "${OSTYPE}" == "darwin"* ]]; then
  brew install readline xz
fi

# install pyenv + pyenv-virtualenv using pyenv-installer
echo "Installing python environment"
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

# install main python version
echo "Available versions:"
pyenv install --list | grep -P "\s\d+\.\d+\.\d+$" | column
read -p "Python version to install?: " PYVERSION
echo "Installing python ${PYVERSION}"
pyenv install "${PYVERSION}"

# install base virtualenv
pyenv virtualenv "${PYVERSION}" "${BASE_VENV_NAME}"
. "${PYENV_ROOT}/versions/${BASE_VENV_NAME}/bin/activate"
pip install ${BASE_PKGS}
pyenv global ${PYVERSION} ${BASE_VENV_NAME}

# install poetry
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python

# setup ipython configs
ipython profile create
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ln -sf "${DIR}/../configs/ipython/ipython_config.py" \
  "$HOME/.ipython/profile_default/ipython_config.py"
ln -s "${DIR}/../configs/ipython/ipython_vi_mode.py" \
  "$HOME/.ipython/profile_default/startup/ipython_vi_mode.py"

#!/bin/bash


# setup home directory structure
echo "Setting up home directory"
mkdir -pv "$HOME/workspaces" "$HOME/.config" "$HOME/.ssh" 

# symbolic links
echo "Linking dotfiles"
ln -sf $HOME/dotfiles/zshrc $HOME/.zshrc
ln -sf $HOME/dotfiles/p10k.zsh $HOME/.p10k.zsh
ln -sf $HOME/dotfiles/tmux.conf $HOME/.tmux.conf
ln -sf $HOME/dotfiles/configs/nvim $HOME/.config/nvim
ln -sf $HOME/dotfiles/configs/git $HOME/.config/git
ln -sf $HOME/dotfiles/configs/ipython/ipython_config.py \
  $HOME/.ipython/profile_default/ipython_config.py
ln -sf $HOME/dotfiles/configs/ipython/ipython_vi_mode.py \
  $HOME/.ipython/profile_default/startup/ipython_vi_mode.py

echo "Installing basic packages"
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install -y --no-install-recommends \
  build-essential \
  tmux \
  zsh

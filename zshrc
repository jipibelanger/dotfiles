# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#
# Zinit configuration
#

[[ ! -f ~/.zinit/bin/zinit.zsh ]] && {
  command mkdir -p "${HOME}/.zinit"
  command chmod 755 "${HOME}/.zinit"
  command git clone https://github.com/zdharma/zinit "${HOME}/.zinit/bin"
}

source "${HOME}/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# prompt
zinit ice atload'!source "${HOME}/.p10k.zsh"' lucid nocd
zinit light romkatv/powerlevel10k

# ls_colors: https://zdharma.org/zinit/wiki/LS_COLORS-explanation/
zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
  atpull'%atclone' pick"clrs.zsh" nocompile'!' \
  atload'zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"'
zinit light trapd00r/LS_COLORS

# pyenv: https://zdharma.org/zinit/wiki/GALLERY/
zinit ice atclone'PYENV_ROOT="$HOME/.pyenv" ./libexec/pyenv init - > zpyenv.zsh' \
    atinit'export PYENV_ROOT="$HOME/.pyenv"' atpull"%atclone" \
    as'command' pick'bin/pyenv' src"zpyenv.zsh" nocompile'!'
zinit light pyenv/pyenv

#
# ZSH settings
#

autoload -U colors && colors # Load Colors.
unsetopt case_glob           # Use Case-Insensitve Globbing.
setopt globdots              # Glob Dotfiles As Well.
setopt extendedglob          # Use Extended Globbing.
setopt brace_ccl             # Allow Brace Character Class List Expansion.
setopt long_list_jobs        # List Jobs In The Long Format By Default.
setopt notify                # Report Status Of Background Jobs Immediately.
setopt auto_param_slash      # If Completed Parameter Is A Directory, Add A Trailing Slash.

# set zstyles options
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:*:*:default' menu yes select

#
# User configuration
#

# vi mode with jk map
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode

# editor settings
export EDITOR="vim"
export VISUAL="nvim"

# aliases
alias e="${VISUAL:-${EDITOR}}"
# utilities
alias grep="grep --color=auto"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias ln="ln -i"
alias du="du -h"
# ls output
[[ "$OSTYPE" == "darwin"* ]] && {
  # use gnu-coreutils on MacOS
  PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
}
alias ls="ls --group-directories-first --color=auto"
alias l='ls -1A'  # one column, hidden files.
alias ll='ls -lh' # human readable sizes.
alias lr='ll -R'  # human readable sizes, recursively.
alias la='ll -A'  # human readable sizes, hidden files.
alias lar='la -R' # human readable sizes, recursively.
# git
alias gs='git status --short'
alias gS='git status'
alias ga='git add'
alias gcm='git commit --message'
alias gpu='git push -u'
alias gd='git diff --no-ext-diff'
alias gD='git diff --no-ext-diff --word-diff'
alias gco='git checkout'
# tmux
# [[ "$TMUX" == "" ]] && {tmux new-session -s tmux}  # tmux
alias tm="tmux new-session -s tmux"
alias ktm="tmux kill-server"
# WSL
alias clip="/mnt/c/Windows/System32/clip.exe"

# python environment
export PATH="$HOME/.poetry/bin:$PATH"  # poetry

# rust environment
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/library"

# project(s) aliases
alias pj="cd ~/workspaces/resolve/sentinel/market_data"

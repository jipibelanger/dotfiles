# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
# redirects DISPLAY to localhost for WSL
export DISPLAY=localhost:0.0

# python environment
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"  # poetry
[[ -x "$(command -v pyenv)" ]] && {
  eval "$(pyenv init -)"
}
[[ -x "$(command -v pyenv virtualenv)" ]] && {
  eval "$(pyenv virtualenv-init -)"
}

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

# completions: https://zdharma.org/zinit/wiki/Example-Minimal-Setup/
zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
  blockf atpull'zinit creinstall -q .' \
      zinit light zsh-users/zsh-completions

# ls_colors: https://zdharma.org/zinit/wiki/LS_COLORS-explanation/
zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
  atpull'%atclone' pick"clrs.zsh" nocompile'!' \
  atload'zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"'
zinit light trapd00r/LS_COLORS

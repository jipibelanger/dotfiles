# Start tmux
if [[ "${TMUX}" = "" ]]; then tmux new-session -s tmux; fi
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zinit setup
source ~/.zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# zinit configs
# prompt
zinit ice depth=1; zinit light romkatv/powerlevel10k

# completions
zinit wait lucid \
  atload'zicompinit; zicdreplay; zstyle ":completion:*" menu select' \
  blockf for zsh-users/zsh-completions

# better LS_COLORs
zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light trapd00r/LS_COLORS

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# vi mode with jk map
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode

# editor settings
export EDITOR=vi
export VISUAL=nvim

# general aliases
alias e="${(z)VISUAL:-${(z)EDITOR}}"
alias grep="${aliases[grep]:-grep} --color=auto"

# safe operations
alias rm="${aliases[rm]:-rm} -i"
alias mv="${aliases[mv]:-mv} -i"
alias cp="${aliases[cp]:-cp} -i"
alias ln="${aliases[ln]:-ln} -i"

# ls aliases
alias ls="${aliases[ls]:-ls} --group-directories-first --color=auto"
alias l='ls -1A'  # Lists in one column, hidden files.
alias ll='ls -lh' # Lists human readable sizes.
alias lr='ll -R'  # Lists human readable sizes, recursively.
alias la='ll -A'  # Lists human readable sizes, hidden files.
alias lar='la -R'  # Lists human readable sizes, recursively.

# git aliases
alias gs='git status --short'
alias gS='git status'
alias ga='git add'
alias gcm='git commit --message'
alias gpu='git push -u'
alias gd='git diff --no-ext-diff'
alias gD='git diff --no-ext-diff --word-diff'
alias gco='git checkout'

# tmux aliases
alias tm="tmux new-session -s tmux"
alias ktm="tmux kill-server"

# pyenv
if [[ -d "${HOME}/.pyenv" ]]; then
  export PYENV_ROOT="${HOME}/.pyenv"
  export PATH="${PYENV_ROOT}/bin:${PATH}"
  export WORKON_HOME=~/.ve
  eval "$(pyenv init -)"
fi

# poetry
if [[ -d "${HOME}/.poetry" ]]; then
  export PATH="${HOME}/.poetry/bin:${PATH}"
fi

# redirects DISPLAY to localhost for WSL
export DISPLAY=localhost:0.0

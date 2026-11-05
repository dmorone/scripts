# Sourced from both ~/.zshrc (macOS) and ~/.bashrc (Linux).
if [ -n "${ZSH_VERSION:-}" ]; then
  _sh=zsh
elif [ -n "${BASH_VERSION:-}" ]; then
  _sh=bash
else
  _sh=
fi

# Prompt. Install starship with brew (macOS) or your package manager (Linux)
# remember to install a font with icons
# (e.g., Fira code https://github.com/tonsky/FiraCode)
# and set it in terminal app
export STARSHIP_CONFIG=~/.scripts/starship.toml
if [ -n "$_sh" ] && command -v starship >/dev/null 2>&1; then
  eval "$(starship init "$_sh")"
fi

# History
export HISTSIZE=1000000000
if [ "$_sh" = zsh ]; then
  export HISTFILE="$HOME/.zsh_history"
  export SAVEHIST=1000000000
  setopt EXTENDED_HISTORY
  setopt autocd
elif [ "$_sh" = bash ]; then
  export HISTFILE="$HOME/.bash_history"
  export HISTFILESIZE=$HISTSIZE
  export HISTTIMEFORMAT='%F %T '
  shopt -s histappend
  shopt -s autocd 2>/dev/null # bash >= 4
fi

# fuzzy search. Install fzf with brew or apt. Use Ctrl+R
if [ -n "$_sh" ] && command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --$_sh)"
fi

# Stuff that I use
alias em='emacs'
alias emnw='emacs --no-window-system'

alias ..='cd ..'
alias 2..='cd ../..'
alias 3..='cd ../../..'
alias 4..='cd ../../../..'
alias 5..='cd ../../../../..'

mkcd () {
  \mkdir -p "$1"
  cd "$1"
}

tempe () {
  cd "$(mktemp -d)"
  chmod -R 0700 .
  if [[ $# -eq 1 ]]; then
    \mkdir -p "$1"
    cd "$1"
    chmod -R 0700 .
  fi
}

unset _sh

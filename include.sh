# ZSH. Install starship
export STARSHIP_CONFIG=~/.scripts/starship.toml
eval "$(starship init zsh)" # Install with brew
# remember to install a font with icons
# (e.g., Fira code https://github.com/tonsky/FiraCode)
# and set it in terminal app

# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000000
export SAVEHIST=1000000000
setopt EXTENDED_HISTORY

eval "$(fzf --zsh)" # fuzzy search. Install fzf with brew. Use Ctrl+R

# Stuff that I use
alias em='emacs'
alias emnw='emacs --no-window-system'

alias ..='cd ..'
alias 2..='cd ../..'
alias 3..='cd ../../..'
alias 4..='cd ../../../..'
alias 5..='cd ../../../../..'
setopt autocd

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

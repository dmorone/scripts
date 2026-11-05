export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY

# Search past commands
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# Enable fuzzy search for history
# brew install fzf
# export FZF_DEFAULT_COMMAND='history -100000'
source <(fzf --zsh)

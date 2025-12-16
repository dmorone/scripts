# Search past commands
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward
# Enable fuzzy search for history
# brew install fzf
export FZF_DEFAULT_COMMAND='history -100000'

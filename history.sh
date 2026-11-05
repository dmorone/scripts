if [ -n "${ZSH_VERSION:-}" ]; then
  _sh=zsh
elif [ -n "${BASH_VERSION:-}" ]; then
  _sh=bash
else
  _sh=
fi

export HISTSIZE=1000000000
if [ "$_sh" = zsh ]; then
  export SAVEHIST=$HISTSIZE
  setopt EXTENDED_HISTORY
elif [ "$_sh" = bash ]; then
  export HISTFILESIZE=$HISTSIZE
  export HISTTIMEFORMAT='%F %T '
  shopt -s histappend
fi

# Search past commands
if [ "$_sh" = zsh ]; then
  bindkey "^[[A" history-search-backward
  bindkey "^[[B" history-search-forward
elif [ "$_sh" = bash ] && [[ $- == *i* ]]; then
  bind '"\e[A": history-search-backward'
  bind '"\e[B": history-search-forward'
fi

# Enable fuzzy search for history
# brew install fzf (or apt install fzf)
# export FZF_DEFAULT_COMMAND='history -100000'
if [ -n "$_sh" ] && command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --$_sh)"
fi

unset _sh

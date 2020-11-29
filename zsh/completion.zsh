# Suggestions descriptions.
builtin zstyle ':completion:*:corrections'  format ' %F{green}-- %d (errors: %e) --%f'
builtin zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
builtin zstyle ':completion:*:messages'     format ' %F{purple} -- %d --%f'
builtin zstyle ':completion:*:warnings'     format ' %F{red}-- no matches found --%f'
builtin zstyle ':completion:*'              format ' %F{yellow}-- %d --%f'

# Select completions with arrows
zstyle ':completion:*' menu select

# Want case-insensitive matching only if there are no case-sensitive matches
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

setopt complete_in_word # more intuitive completions

# macOS
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
  autoload -Uz compinit
  compinit
fi

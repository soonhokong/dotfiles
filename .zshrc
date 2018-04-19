# If not running interactively, don't do anything
[[ -o interactive ]] || return

#
# zplug
#
autoload -U is-at-least
if is-at-least 4.3.9 && [[ -f ~/.zplug/init.zsh ]]; then
  source ~/.zplug/init.zsh

  zplug "simnalamburt/cgitc"
  zplug "simnalamburt/zsh-expand-all"
  zplug "zsh-users/zsh-completions"
  zplug "zsh-users/zsh-autosuggestions"
  zplug "zsh-users/zsh-syntax-highlighting", defer:2

  zplug "g-plane/zsh-yarn-autocompletions", hook-build:"./zplug.zsh", defer:2

  if is-at-least 5.2.0; then
    zplug "mafredri/zsh-async"
    zplug "sindresorhus/pure", use:pure.zsh, as:theme
  else
    zplug "simnalamburt/shellder", as:theme
  fi

  zplug load
else
  PS1='%n@%m:%~%(!.#.$) '
fi

# Pure
autoload -U promptinit; promptinit
prompt pure

#
# zsh-sensible
#
stty stop undef

alias l='ls -lah'
alias mv='mv -i'
alias cp='cp -i'

setopt auto_cd histignorealldups sharehistory
zstyle ':completion:*' menu select

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history


#
# lscolors
#
autoload -U colors && colors
export LSCOLORS="Gxfxcxdxbxegedxbagxcad"
export LS_COLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=0;41:sg=30;46:tw=0;42:ow=30;43"
export TIME_STYLE="+%y%m%d"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

#
# zsh-substring-completion
#
setopt complete_in_word
setopt always_to_end
WORDCHARS=''
zmodload -i zsh/complist

# Substring completion
zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'


#
# notify
#
if (( $+commands[osascript] )); then
  notify () {
    cat <<END | osascript
      display notification "$*" sound name "Glass" with title "Shell Notification"
      say "$*"
END
  }
fi


#
# zshrc
#
if [[ -f ~/.fzf.zsh ]]; then source ~/.fzf.zsh; fi
if [[ "$TMUX" = "" ]]; then export TERM="xterm-256color"; fi
export DEFAULT_USER="$USER" # TODO: https://github.com/simnalamburt/shellder/issues/10

# Aliases
if (( $+commands[tmux] )); then alias irc='tmux attach -t irc'; fi

# Neovim
if (( $+commands[nvim] )); then
  export EDITOR=nvim
fi

# Terraform
if (( $+commands[terraform] )); then
  export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
fi

# Golang
if (( $+commands[go] )) && [[ -d ~/.go ]]; then
  export GOPATH="$HOME/.go"
  export PATH="$PATH:$GOPATH/bin"
fi

# Ruby
if (( $+commands[ruby] )) && (( $+commands[gem] )); then
  GEM_HOME=$(ruby -e 'print Gem.user_dir')
  export GEM_HOME
  export PATH="$PATH:$GEM_HOME/bin"
fi

# cargo install
if [[ -d ~/.cargo/bin ]]; then
  export PATH="$PATH:$HOME/.cargo/bin"
fi
# yarn global
if (( $+commands[yarn] )); then
  export PATH="$PATH:$HOME/.config/yarn/global/node_modules/.bin"
fi

# exa
if (( $+commands[exa] )); then
  alias l='exa -alh --group-directories-first'
  alias ll='exa -lh --group-directories-first'
fi

# tag
if (( $+commands[tag] )) && (( $+commands[rg] )); then
  export TAG_SEARCH_PROG=rg
  tag() {
    command tag "$@"; source "${TAG_ALIAS_FILE:-/tmp/tag_aliases}" 2>/dev/null
  }
  alias rg=tag  # replace with rg for ripgrep
fi

# Couchbase tools
if [[ -d '/Applications/Couchbase Server.app/Contents/Resources/couchbase-core/bin/' ]]; then
  export PATH="$PATH:/Applications/Couchbase Server.app/Contents/Resources/couchbase-core/bin/"
fi


#
# Load local configs
#
if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi

# Platform-dependent stuff
source "${ZDOTDIR:-${HOME}}/.zshrc-`uname`"

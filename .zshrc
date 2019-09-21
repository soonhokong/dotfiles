# exa
if (( $+commands[exa] )); then
  alias l='exa -alh --group-directories-first'
  alias ll='exa -lh --group-directories-first'
fi

# Directory coloring
if [[ $OSTYPE = (darwin|freebsd)* ]]; then
    export CLICOLOR=true
    export LSCOLORS='exfxcxdxbxGxDxabagacad'
fi
if [[ $OSTYPE = (linux)* ]]; then
    export COLOR_OPTIONS='--color=auto'
fi

# Aliases
alias la='ls -lah $COLOR_OPTIONS'
alias lh='ls -lh $COLOR_OPTIONS'
alias ls='ls $COLOR_OPTIONS'
alias l='ls $COLOR_OPTIONS'

# Aliases for bazel
alias btd='bazel test --compilation_mode=dbg'
alias bto='bazel test --compilation_mode=opt'
alias bbd='bazel build --compilation_mode=dbg'
alias bbo='bazel build --compilation_mode=opt'

# Use the Emacs-like keybindings
bindkey -e

# Keybindings for substring search plugin. Maps up and down arrows.
bindkey -M main '^[OA' history-substring-search-up
bindkey -M main '^[OB' history-substring-search-down
bindkey -M main '^[[A' history-substring-search-up
bindkey -M main '^[[B' history-substring-search-up

# DRAKE: Gurobi/Mosek Licenses / SNOPT
export GRB_LICENSE_FILE=$HOME/gurobi.lic
export MOSEKLM_LICENSE_FILE=$HOME/mosek/mosek.lic
export SNOPT_PATH=git

# Update PATH
export PATH=~/bin:~/.local/bin:$PATH:`python3 -m site --user-base`/bin
export EDITOR=emacsclient
export LESS='-R'

# Platform-dependent stuff
source "${ZDOTDIR:-${HOME}}/.zshrc-`uname`"

# zplug
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3

# For pure prompt
RPROMPT='%F{white}%*'  # Display time on the right
zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme

zplug load

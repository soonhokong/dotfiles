# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# exa
if (( $+commands[exa] )); then
  alias l='exa -alh --group-directories-first'
  alias ll='exa -lh --group-directories-first'
fi

# Platform-dependent stuff
source "${ZDOTDIR:-${HOME}}/.zshrc-`uname`"

# Gurobi/Mosek Licenses
export GRB_LICENSE_FILE=$HOME/gurobi.lic
export MOSEKLM_LICENSE_FILE=$HOME/mosek/mosek.lic

export PATH=~/bin:~/.local/bin:$PATH

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export EDITOR=emacsclient

export LESS='-R'

# opam configuration
test -r ${HOME}/.opam/opam-init/init.zsh && . ${HOME}/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

export SNOPT_PATH=git

alias btd='bazel test'
alias bto='bazel test'
alias bbd='bazel build'
alias bbo='bazel build'

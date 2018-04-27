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

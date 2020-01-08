export HISTFILE=~/.zsh_history
export HISTSIZE=10000000
export SAVEHIST=10000000

setopt append_history # better concurrent shell history sharing
setopt extended_history # better history
setopt hist_expire_dups_first # don't fill your history as quickly with junk
setopt hist_ignore_space # ` command` doesn't save to history
setopt hist_subst_pattern # better globs / parameter expansion
setopt hist_reduce_blanks # `a  b` normalizes to `a b` in history
setopt hist_verify # reduce oops I sudoed the wrong thing
setopt share_history # better concurrent shell history sharing

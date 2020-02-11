# ls => exa
alias ls='exa'
alias l='exa -alh --group-directories-first'
alias ll='exa -lh --group-directories-first'

# emacs
alias e='emacsclient'
alias et='emacsclient -t'
alias ec='emacsclient -c'

# Aliases for bazel
alias btd='bazel test --compilation_mode=dbg'
alias bto='bazel test --compilation_mode=opt'
alias bbd='bazel build --compilation_mode=dbg'
alias bbo='bazel build --compilation_mode=opt'

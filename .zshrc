HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

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
alias ll='ls -l $COLOR_OPTIONS'
alias l='ls $COLOR_OPTIONS'

# Aliases for bazel
alias btd='bazel test --compilation_mode=dbg'
alias bto='bazel test --compilation_mode=opt'
alias bbd='bazel build --compilation_mode=dbg'
alias bbo='bazel build --compilation_mode=opt'

# Use the Emacs-like keybindings
bindkey -e

# Keybindings for substring search plugin. Maps up and down arrows.
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# DRAKE: Gurobi/Mosek Licenses / SNOPT
export GRB_LICENSE_FILE=$HOME/gurobi.lic
export MOSEKLM_LICENSE_FILE=$HOME/mosek/mosek.lic
export SNOPT_PATH=git

# Update PATH
export PATH=~/bin:~/.local/bin:$PATH:`python3 -m site --user-base`/bin
export EDITOR=emacsclient
export LESS='-R'

# see zshoptions(1) for details on what these do
# see also zshexpn(1) for details on how globbing works
setopt append_history # better concurrent shell history sharing
setopt auto_pushd # cd foo; cd bar; popd --> in foo again
setopt complete_in_word # more intuitive completions
setopt no_beep # BEEP
setopt extended_glob # better globs
setopt extended_history # better history
# setopt glob_complete # (see manual for description & tradeoffs)
setopt glob_star_short # ** means **/*, **/ means directory only **
setopt hist_expire_dups_first # don't fill your history as quickly with junk
setopt hist_ignore_space # ` command` doesn't save to history
setopt hist_subst_pattern # better globs / parameter expansion
setopt hist_reduce_blanks # `a  b` normalizes to `a b` in history
setopt hist_verify # reduce oops I sudoed the wrong thing
setopt interactive_comments # so pasting live to test works
setopt ksh_glob # better globs
setopt long_list_jobs # easier to read job stuff
setopt null_glob # sane globbing
setopt pipe_fail # fail when the first command in a pipeline fails
setopt share_history # better concurrent shell history sharing
setopt no_rm_star_silent # confirm on `rm *` (default, but let's be safe)
setopt prompt_cr prompt_sp # don't clobber output without trailing newlines
# setopt rm_star_wait # wait after confirmation on `rm *` to allow ^C

# Platform-dependent stuff
source "${ZDOTDIR:-${HOME}}/.zshrc-`uname`"

# ---
# fzf
# ---
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

# -----
# zplug
# -----
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# (defer:2 means syntax-highlighting gets loaded after completions)
zplug 'zsh-users/zsh-syntax-highlighting', defer:2 # (like fish)
# (defer:3 means history-substring search gets loaded after syntax-highlighting)
zplug 'zsh-users/zsh-history-substring-search', defer:3 # (like fish)
zplug 'zsh-users/zsh-autosuggestions' # (like fish)
zplug 'zsh-users/zsh-completions', depth:1 # more completions

# For pure prompt
RPROMPT='%F{white}%*'  # Display time on the right
zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme

# fzf
zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf
zplug "junegunn/fzf", use:"shell/*.zsh", defer:2

# fd
zplug 'sharkdp/fd', as:command, from:gh-r

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

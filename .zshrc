HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history

# autoload
autoload -Uz run-help
autoload -Uz add-zsh-hook
autoload -Uz colors && colors
autoload -Uz compinit && compinit -u
autoload -Uz is-at-least

# LANGUAGE must be set by en_US
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

# Pager
export PAGER=less
# Less status line
export LESS='-R -f -X -i -P ?f%f:(stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]'
export LESSCHARSET='utf-8'

# LESS man page colors (makes Man pages more readable).
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[00;44;37m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# ls command colors
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# declare the environment variables
export CORRECT_IGNORE='_*'
export CORRECT_IGNORE_FILE='.*'
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
export WORDCHARS='*?.[]~&;!#$%^(){}<>'

# ls => exa
alias ls='exa'
alias l='exa -alh --group-directories-first'
alias ll='exa -lh --group-directories-first'

# emacs
alias e='emacsclient'
alias et='emacsclient -t'

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

# Want case-insensitive matching only if there are no case-sensitive matches
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

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

# Weather
wttr()
{
    local request="wttr.in/${1-02476}?m"
    [ "$(tput cols)" -lt 125 ] && request+='?n'
    curl -H "Accept-Language: ${LANG%_*}" --compressed "$request"
}

# Platform-dependent stuff
source "${ZDOTDIR:-${HOME}}/.zshrc-`uname`"

# -------
# zplugin
# -------
ZPLUGIN_HOME=$HOME/.zplugin
if [ ! -d "${ZPLUGIN_HOME}" ]; then
   mkdir ~/.zplugin
   git clone https://github.com/zdharma/zplugin.git ~/.zplugin/bin
fi
if [ ! -f "${ZPLUGIN_HOME}/bin/zplugin.zsh" ]; then
    echo "zplugin is not properly installed. Please check."
fi
source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin


zplugin light zsh-users/zsh-autosuggestions
zplugin light zdharma/fast-syntax-highlighting
zplugin load zdharma/history-search-multi-word
zplugin light zsh-users/zsh-history-substring-search
zplugin light zsh-users/zsh-completions

# Load the pure theme, with zsh-async library that's bundled with it.
RPROMPT='%F{white}%*'  # Display time on the right
zplugin ice pick"async.zsh" src"pure.zsh"
zplugin light sindresorhus/pure

# Binary release in archive, from GitHub-releases page.
# After automatic unpacking it provides program "fzf".
zplugin ice from"gh-r" as"command"
zplugin load junegunn/fzf-bin


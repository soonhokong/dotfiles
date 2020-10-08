[ -d "${HOME}/.poetry" ] || sh -c "curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python"

# autoload
autoload -Uz run-help
autoload -Uz add-zsh-hook
autoload -Uz colors && colors
[ -d "${HOME}/.poetry" ] && fpath+=~/.zfunc
autoload -Uz compinit
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

# Use the Emacs-like keybindings
bindkey -e

# DRAKE: Gurobi/Mosek Licenses / SNOPT
export GRB_LICENSE_FILE=$HOME/gurobi.lic
export MOSEKLM_LICENSE_FILE=$HOME/mosek/mosek.lic
export SNOPT_PATH=git

export EDITOR=emacsclient
export LESS='-R'

# see zshoptions(1) for details on what these do
# see also zshexpn(1) for details on how globbing works
setopt auto_pushd # cd foo; cd bar; popd --> in foo again
setopt no_beep # BEEP
setopt extended_glob # better globs
# setopt glob_complete # (see manual for description & tradeoffs)
setopt glob_star_short # ** means **/*, **/ means directory only **
setopt interactive_comments # so pasting live to test works
setopt ksh_glob # better globs
setopt long_list_jobs # easier to read job stuff
setopt null_glob # sane globbing
setopt pipe_fail # fail when the first command in a pipeline fails
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
source "${HOME}/dotfiles/zsh/platform-$(uname).zsh"
source "${HOME}/dotfiles/zsh/aliases.zsh"
source "${HOME}/dotfiles/zsh/set_history.zsh"
source "${HOME}/dotfiles/zsh/zinit.zsh"
source "${HOME}/dotfiles/zsh/fzf.zsh"
source "${HOME}/dotfiles/zsh/update.zsh"
source "${HOME}/dotfiles/zsh/completion.zsh"

() {
  setopt extendedglob local_options
  if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
    compinit
  else
    compinit -C
  fi
}

if [ -e "${HOME}/.pyenv" ]; then
    case $(uname -s) in
	Darwin)
	    eval "$(pyenv init - --no-rehash zsh)"
	    ;;
	Linux)
	    export PATH="${HOME}/.pyenv/bin:$PATH"
	    eval "$(pyenv init - --no-rehash zsh)"
	    eval "$(pyenv virtualenv-init -)"
	    # driving-specific
	    export DRIVING_BAZEL_REMOTE_CACHE=s3
	    ;;
    esac
fi

if [ -e "${HOME}/.pyenv" ]; then
    case $SYSTEM in
	Darwin)
	    eval "$(pyenv init - --no-rehash zsh)"
	    ;;
	Linux)
	    export PATH="/home/soonhokong/.pyenv/bin:$PATH"
	    eval "$(pyenv init - --no-rehash zsh)"
	    eval "$(pyenv virtualenv-init -)"
	    ;;
    esac
fi

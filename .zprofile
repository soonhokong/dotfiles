if [ -e "${HOME}/.pyenv" ]; then
    case $(uname -s) in
	Darwin)
	    eval "$(pyenv init - --no-rehash zsh)"
	    ;;
	Linux)
	    export PATH="${HOME}/.pyenv/bin:$PATH"
	    eval "$(pyenv init - --no-rehash zsh)"
	    eval "$(pyenv virtualenv-init -)"
	    ;;
    esac
fi

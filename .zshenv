# Update PATH
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# pyenv
export PATH="$HOME/.pyenv/bin:$PATH"

# poetry
export POETRY_HOME="$HOME/.poetry"
export PATH="$PATH:$POETRY_HOME/bin"

. "$HOME/.cargo/env"

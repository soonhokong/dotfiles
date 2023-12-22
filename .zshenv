# Update PATH
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# pyenv
export PATH="$HOME/.pyenv/bin:$PATH"

# poetry
export POETRY_HOME="$HOME/.poetry"
export PATH="$PATH:$POETRY_HOME/bin"

if [ -f "$HOME/.cargo/env" ]; then . "$HOME/.cargo/env"; fi

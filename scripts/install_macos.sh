#!/bin/bash
#
# Install development and runtime prerequisites for both binary and source
# distributions of Drake on macOS.

set -euxo pipefail

# Install homebrew if it is not installed.
if ! command -v /usr/local/bin/brew &>/dev/null; then
  /usr/bin/ruby -e "$(/usr/bin/curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install zplug if it is not installed.
if [[ ! -d ${HOME}/.zplug ]]; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

brew bundle --file=~/dotfiles/homebrew/Brewfile

brew services start d12frosted/emacs-plus/emacs-plus  # Start emacs daemon

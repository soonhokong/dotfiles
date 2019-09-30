#!/usr/bin/env bash
set -euxo pipefail

# Pull dotfiles
git -C ~/dotfiles pull

# Update / upgrade packages installed via homebrew
brew update && brew upgrade && brew cask upgrade && brew cleanup -s

# LaTeX packages
tlmgr update --all

# PIP packages
pipupgrade -y --user

# Upgrade packages installed via Mac App Store
mas upgrade

# MacOS Software Update
softwareupdate -i -a

# Update / upgrade emacs packages
emacs --no-window-system --eval "(auto-package-update-now)" --kill

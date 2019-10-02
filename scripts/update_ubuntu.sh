#!/usr/bin/env bash
set -euxo pipefail

# Pull dotfiles
git -C ~/dotfiles pull

# Update / upgrade packages installed via apt
sudo apt-get update
sudo apt-get upgrade --yes
sudo apt-get autoremove
sudo apt-get autoclean

# Update / upgrade emacs packages
emacs --no-window-system --eval "(auto-package-update-now)" --kill

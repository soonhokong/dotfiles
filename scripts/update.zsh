update() {
    update_common() {
	# Pull dotfiles
	git -C ~/dotfiles pull

	zplug update

	# Update / upgrade emacs packages
	emacs --no-window-system --eval "(auto-package-update-now)" --kill
    }

    update_darwin() {
	# Update / upgrade packages installed via homebrew
	brew update && brew upgrade && brew cask upgrade && brew cleanup -s

	# LaTeX packages
	tlmgr update --all

	# Upgrade packages installed via Mac App Store
	mas upgrade

	# MacOS Software Update
	softwareupdate -i -a
    }

    update_ubuntu() {
	# Update / upgrade packages installed via apt
	sudo apt-get update
	sudo apt-get upgrade --yes
	sudo apt-get autoremove
	sudo apt-get autoclean
    }

    update_common
    if [ "$(uname -s)" = 'Darwin' ]; then
	update_darwin
    else
	update_ubuntu
    fi
}

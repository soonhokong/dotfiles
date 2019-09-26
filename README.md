dotfiles
--------

macOS
=====

Install packages via [homebrew](https://brew.sh).
```bash
brew bundle --file=~/dotfiles/homebrew/Brewfile
```

Ubuntu 18.04 (Bionic)
=====================

[emacs](https://www.gnu.org/software/emacs/) 26

```bash
sudo add-apt-repository ppa:kelleyk/emacs
sudo apt-get update
sudo apt-get install emacs26
```

[zsh](http://zsh.sourceforge.net) + [zplug](https://github.com/zplug/zplug)

```bash
sudo apt install zsh gwak  # gwak is needed for zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
```

Common
======

emacs Setup
-----------
```bash
mkdir -p ~/.emacs.d
cd ~/.emacs.d
ln -s ../dotfiles/.emacs.d/init.el
ln -s ../dotfiles/.emacs.d/settings.org
touch ~/.emacs.d/custom.el
```

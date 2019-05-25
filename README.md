dotfiles
--------


macOS
=====

Install packages via homebrew
```bash
brew install exa npm zsh zsh-syntax-highlighting
```

Install emacs26.1 from https://emacsformacosx.com/builds

zsh + [prezto](https://github.com/sorin-ionescu/prezto) + [pure theme](https://github.com/sindresorhus/pure) + [zplug](https://github.com/zplug/zplug)
```bash
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
npm install --global pure-prompt
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
```

   
Ubuntu 16.04 (Xenial)
=====================

emacs26

```bash
sudo add-apt-repository ppa:kelleyk/emacs
sudo apt-get update
sudo apt-get install emacs26
```

zsh + [prezto](https://github.com/sorin-ionescu/prezto) + [pure theme](https://github.com/sindresorhus/pure) + [zplug](https://github.com/zplug/zplug)

```bash
sudo apt install npm zsh zsh-syntax-highlighting
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
sudo npm install --global pure-prompt --allow-root --unsafe-perm=true
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

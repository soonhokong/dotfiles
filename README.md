dotfiles
--------


macOS
=====

Install packages via homebrew
```bash
brew install exa npm zsh zsh-syntax-highlightin
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

emacs25

```bash
sudo add-apt-repository ppa:ubuntu-elisp/ppa -y
sudo apt-get update
sudo update-alternatives --config emacs    # To make emacs25 default.
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

[ycmd](https://github.com/Valloric/ycmd)
-----

```bash
mkdir -p ~/work/ && cd ~/work
git clone https://github.com/Valloric/ycmd.git
cd ycmd
git submodule update --init --recursive
./build.py --clang-completer
```

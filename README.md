dotfiles
--------

macOS
=====

Install packages via [homebrew](https://brew.sh).
```bash
brew bundle --file=~/dotfiles/homebrew/Brewfile
brew services start d12frosted/emacs-plus/emacs-plus  # Start emacs daemon
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

emacs daemon for Ubuntu
-----------------------

Create `~/.config.systemd/user/emacs.service`.
```
## If your Emacs is installed in a non-standard location, you may need
## to copy this file to a standard directory, eg ~/.config/systemd/user/ .
## If you install this file by hand, change the "Exec" lines below
## to use absolute file names for the executables.
[Unit]
Description=Emacs text editor
Documentation=info:emacs man:emacs(1) https://gnu.org/software/emacs/

[Service]
Type=simple
ExecStart=/usr/bin/emacs --fg-daemon
ExecStop=/usr/bin/emacsclient --eval "(kill-emacs)"
Environment=SSH_AUTH_SOCK=%t/keyring/ssh
Restart=on-failure

[Install]
WantedBy=default.target
```

Run the following to enable and start a daemon.
```bash
systemctl enable --user emacs                                                                                                                                                                                                                                                    9:49:58
systemctl start --user emacs
```

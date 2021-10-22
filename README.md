dotfiles
--------

macOS
=====

```bash
zsh ~/dotfiles/scripts/install_macos.sh
```

Ubuntu 18.04 (Bionic)
=====================

[emacs](https://www.gnu.org/software/emacs/) 26

```bash
sudo add-apt-repository ppa:kelleyk/emacs
sudo apt-get update
sudo apt-get install emacs26
```

[zsh](http://zsh.sourceforge.net)

```bash
sudo apt install zsh
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

Run the following to enable and start a daemon.
```bash
mkdir -p ~/.config/systemd/user
cp ~/dotfiles/ubuntu/emacs.service ~/.config/systemd/user/emacs.service
systemctl enable --user emacs
systemctl start --user emacs
systemctl restart --user emacs  # to restart
```

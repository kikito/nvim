# nvim

This is my custom neovim installation. I've tested it on a Mac with OSX

## Installation

Prerequisite: install python3 with the neovim client for the python-reliant
plugins to work.

```
brew install python3
pip3 install neovim
```

Prerequisite: Fix OSX settings for the terminal regarding Control-H
([reference](https://github.com/neovim/neovim/issues/2048#issuecomment-78045837))

```
infocmp $TERM | sed 's/kbs=^[hH]/kbs=177/' > $TERM.ti
tic $TERM.ti
```

Installation:
```
mkdir -p ~/.config
cd ~/.config
git clone https://github.com/kikito/nvim
```

Customize `~/.config/nvim/init.vim` to your liking and then enter neovim and
install all the plugins:
```
:PlugInstall
```

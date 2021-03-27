# My Dotfiles

This repository contains my dotfiles that I use on various machines.
Inspired by many dotfiles other people use, r/unixporn and so on.

## Installation

Using [GNU stow](https://alexpearce.me/2016/02/managing-dotfiles-with-stow/).
Note that the base-programs themself must be installed first.
E.g. `nvim` will only be configurable if it is installed in your system.

```bash
$ git clone ...
$ cd dotfiles
$ # Those are straight forward.
$ stow htop tmux
$ # My nvim has multiple plugins and might need a bit more work!
$ stow nvim
$ # ZSH requires the installations of the proper theme, see pre-requisites
$ stow zsh
```

Check the pre-requisites for the packages first!

## Pre-requisites

This section tracks what special things might be necessary for some tools.
This could be the installation additional tools or themes.
It might be a list of steps to take in order to get a program fully up and
ready.

### nvim

1. Install [pynvim](https://github.com/neovim/pynvim)
  * Gentoo: `emerge --ask dev-python/pynvim`
2. Install [vim-plug](https://github.com/junegunn/vim-plug)
3. `$ stow nvim`
4. `$ nvim --headless +PlugInstall +qa`

### zsh

1. Install [oh-my-zsh](https://ohmyz.sh/)
2. Make sure that the `${HOME}/.zshrc` file does not exist (`oh-my-zsh` will
   create one)
3. `$ stow zsh`

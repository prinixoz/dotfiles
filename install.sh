#!/bin/bash
# installing package manager
sudo pacman -S git stow
cd /tmp/
git clone "https://aur.archlinux.org/paru-bin" 
cd /tmp/paru-bin
makepkg -si


## Adding my dotfiles and stowing it
cd ~/.local/
git clone https://github.com/prinixoz/dotfiles
cd ~/.local/dotfiles
stow -vt ~ config/ scripts/

## Install Package
sudo pacman -S $(curl "https://raw.githubusercontent.com/prinixoz/dotfiles/main/install.txt")

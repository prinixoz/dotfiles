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

## Setting caotic aur
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

sudo echo "
###################################################################################################

[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist

###################################################################################################
" >> /etc/pacman.conf

## Install Package
paru -S $(cat install.txt) --needed


# installing all the fonts available in Package Manager
# sudo pacman -S (sudo pacman -Ss ttf -q)
fc-cache -fv

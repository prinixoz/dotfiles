#!/bin/sh

source $HOME/.config/shell/export
source $HOME/.config/shell/alias

if [[ "$(tty)" = "/dev/tty1" ]]; then
     ~/.config/X11/xinitrc
fi

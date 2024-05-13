#!/bin/sh
# Environment variable
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE="en_GB.utf8"
export RUST_BACKTRACE=1

## Other XDG paths
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export XDG_STATE_HOME=${XDG_STATE_HOME:="$HOME/.local/share"}

## Disable files
export CABAL_CONFIG="$XDG_CONFIG_HOME"/cabal/config
export CABAL_DIR="$XDG_CACHE_HOME"/cabal
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export HISTFILE="$XDG_STATE_HOME"/bash/history
export LESSHISTFILE=-
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export RXVT_SOCKET="$XDG_RUNTIME_DIR"/urxvtd
export SCREENRC="$XDG_CONFIG_HOME"/screen/screenrc
export VIEB_DATAFOLDER=~/.local/share/Vieb/
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export XAUTHORITY=~/.local/share/Xauthority
export XDG_STATE_HOME=${XDG_STATE_HOME:="$HOME/.config"}
export YTFZF_CONFIG_DIR=$HOME/.config/ytfzf
export YTFZF_CONFIG_FILE=$YTFZF_CONFIG_DIR/conf.sh
export ZDOTDIR="$HOME/.config/zsh"

# Default applications
export BROWSER='librewolf -P default'
export EDITOR='nvim'
export MANPAGER='nvim +Man!'
export RUST_BACKTRACE=1
export TERM="xterm-256color"
export TERMCMD='alacritty -e'
export TERMINAL='alacritty'
export VISUAL='nvim'

export WALLPAPERDIR="/mnt/prinix/project/prinixoz/wallpapers/"

# PATH
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.local/bin/scripts
export PATH=$PATH:$HOME/.local/bin/polybar
export PATH=$PATH:$HOME/.local/bin/start
export PATH=$PATH:$HOME/.local/bin/pywal
export PATH=$PATH:$HOME/.local/bin/links
export PATH=$PATH:$HOME/.local/appimage

source $HOME/.config/shell/export

if [[ "$(tty)" = "/dev/tty1" ]]; then
	startx ~/.config/X11/xinitrc
elif [[ "$(tty)" = "/dev/tty2" ]]; then
	startx ~/.config/X11/xinitrc2
fi

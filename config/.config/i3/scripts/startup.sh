#!/bin/sh
dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY &
swayidle before-sleep lock &
wlsunset -l  28.62190 -L 77.08784 &
dunst &
battery-notify &
udiskie &
# yt-toggle &

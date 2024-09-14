#!/bin/sh
dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY &
#gummy start &
#gummy -T 1 -y 06:00 -u 16:30 --temperature-min 2000 --temperature-max 5000 &
swayidle before-sleep lock
dunst &
battery-notify &
udiskie &
yt-toggle &

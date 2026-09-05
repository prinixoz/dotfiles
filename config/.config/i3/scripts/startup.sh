#!/bin/sh
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
swayidlelock &
sway-audio-idle-inhibit &
dunst &
udiskie &
battery-notify &
overview &
wallpaper &
swaybg -i "/home/user/.cache/wallpaper_modified.png" -m fill &
wlsunset -l  28.62190 -L 77.08784 -t 1000 &
a2ln &
mpd &

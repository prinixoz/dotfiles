#!/bin/sh
gummy start &
gummy -T 1 -y 06:00 -u 16:30 --temperature-min 2000 --temperature-max 5000 &
swayidle before-sleep lock timeout 150 lock &
dunst &
nm-applet &
battery-notify &
udiskie &

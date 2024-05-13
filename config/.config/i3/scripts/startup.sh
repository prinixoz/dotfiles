#!/bin/sh
gummy start &
gummy -T 1 -y 06:00 -u 16:30 --temperature-min 2000 --temperature-max 5000 &
xss-lock -- i3lock -c 000000 &
killall -q rep 
#rep 60 "$HOME/.local/bin/capsesc" &

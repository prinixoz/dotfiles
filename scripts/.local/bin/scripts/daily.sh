#!/bin/bash

# minimal safe environment
export PATH=/usr/bin:/bin:/home/user/.local/bin:/home/user/.local/bin/scripts

LOG="/tmp/daily.log"

echo "========== $(date) ==========" >> "$LOG"

# 1. wallpaper

/home/user/.local/bin/scripts/wallpaper >> "$LOG" 2>&1
# 1. Weather
/home/user/.local/bin/scripts/overview daily >> "$LOG" 2>&1

# 2. Backup (git or whatever your bp does)
/home/user/.local/bin/scripts/bp >> "$LOG" 2>&1

# 3. System updates
sudo /usr/bin/pacman -Syuw >> "$LOG" 2>&1


echo "" >> "$LOG"

#!/usr/bin/env bash

# === CONFIG ===
REMOTE_USER="u0_a330"         # Termux username
REMOTE_HOST="192.168.29.103"    # Termux/phone IP
REMOTE_PORT=8022              # Termux SSH port
REMOTE_PASS="bankai"   # Termux SSH password
INTERVAL=0.5                   # Check interval (seconds)

# === INSTALL CHECKS ===
command -v wl-paste >/dev/null || { echo "Error: wl-paste not found. Install wl-clipboard."; exit 1; }
command -v sshpass >/dev/null || { echo "Error: sshpass not found. Install it via 'sudo pacman -S sshpass'."; exit 1; }

# === MAIN LOOP ===
last_clip=""
while true; do
    clip="$(wl-paste 2>/dev/null)"
    if [[ "$clip" != "$last_clip" ]]; then
        last_clip="$clip"
        # Escape single quotes for safe transmission
        clip_escaped=$(printf "%s" "$clip" | sed "s/'/'\\\\''/g")
        wl-paste > /tmp/copy
        scp /tmp/copy user@laptop.com:copy
        echo "[+] Clipboard sent at $(date +'%H:%M:%S')"
    fi
    sleep $INTERVAL
done


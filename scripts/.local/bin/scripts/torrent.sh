#!/usr/bin/env bash
set -euo pipefail

TORRENT="$1"

STATE=".next_file"

# First file index (1-based)
if [[ ! -f "$STATE" ]]; then
    echo 1 > "$STATE"
fi

FILE=$(<"$STATE")

echo "Downloading file #$FILE..."

aria2c \
    --seed-time=0 \
    --continue=true \
    --select-file="$FILE" \
    "$TORRENT"

STATUS=$?

if [[ $STATUS -eq 0 ]]; then
    echo $((FILE + 1)) > "$STATE"
    echo "Finished file #$FILE"
else
    echo "Download interrupted. Will resume file #$FILE next time."
fi

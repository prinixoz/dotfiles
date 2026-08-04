#!/usr/bin/env bash

set -e

# Automatically capture the directory where this script resides
LIBREWOLF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MASTER_CHROME="$LIBREWOLF_DIR/userChrome.css"
MASTER_CONTENT="$LIBREWOLF_DIR/userContent.css"

# Check if at least one style file exists
if [ ! -f "$MASTER_CHROME" ] && [ ! -f "$MASTER_CONTENT" ]; then
    echo "❌ Error: Neither userChrome.css nor userContent.css found at $LIBREWOLF_DIR"
    exit 1
fi

echo "🔍 Scanning all valid profiles inside $LIBREWOLF_DIR..."

# Find folders that contain standard profile markers (like prefs.js or times.json)
find "$LIBREWOLF_DIR" -maxdepth 2 -type f \( -name "prefs.js" -o -name "times.json" \) | while read -r marker_file; do
    # Get the parent directory of the marker file (the actual profile folder)
    profile_path=$(dirname "$marker_file")
    profile_name=$(basename "$profile_path")
    
    echo "-----------------------------------------------"
    echo "👤 Processing profile: $profile_name"

    CHROME_DIR="$profile_path/chrome"

    # Create the 'chrome' directory if it doesn't exist yet
    if [ ! -d "$CHROME_DIR" ]; then
        echo "   📁 Creating missing 'chrome' directory..."
        mkdir -p "$CHROME_DIR"
    fi

    # Handle userChrome.css (UI Layout)
    if [ -f "$MASTER_CHROME" ]; then
        echo "   🔗 Linking userChrome.css..."
        ln -sf "$MASTER_CHROME" "$CHROME_DIR/userChrome.css"
    fi

    # Handle userContent.css (Web Page Modifications)
    if [ -f "$MASTER_CONTENT" ]; then
        echo "   🔗 Linking userContent.css..."
        ln -sf "$MASTER_CONTENT" "$CHROME_DIR/userContent.css"
    fi
    
    echo "   ✅ Profile sync complete!"
done

echo "-----------------------------------------------"
echo "🎉 Every single profile has been updated with your stylesheets!"

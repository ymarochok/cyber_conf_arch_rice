#!/bin/bash

# Wallpaper directory
WALLPAPER_DIR="$HOME/wallpapers/"

# File to store the index
INDEX_FILE="$HOME/.cache/current_wallpaper_index"

# Get list of files
mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' \) | sort)

# Read current index or default to 0
if [[ -f "$INDEX_FILE" ]]; then
    INDEX=$(<"$INDEX_FILE")
else
    INDEX=0
fi

# Ensure index wraps around
((INDEX++))
if (( INDEX >= ${#WALLPAPERS[@]} )); then
    INDEX=0
fi

# Set wallpaper using swww
swww img "${WALLPAPERS[$INDEX]}" --transition-type any --transition-duration 2 --transition-fps 100

# Save new index
echo "$INDEX" > "$INDEX_FILE"


#!/bin/bash
SCREENSHOT_DIR=~/Pictures/Screenshots
mkdir -p "$SCREENSHOT_DIR"

FILE="$SCREENSHOT_DIR/display_$(date +%Y%m%d_%H%M%S).png"
OUTPUT_ID=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused).name')

if [ -z "$OUTPUT_ID" ]; then
    notify-send -u critical -t 3000 "Screenshot" "Error: Focused display not found."
    exit 1
fi

if grim -o "$OUTPUT_ID" "$FILE"; then
    swappy -f "$FILE" -o "$FILE"
    wl-copy -t image/png < "$FILE"
    notify-send -t 4000 "Screenshot" "Full screen captured!\nSaved to: $FILE\nCopied to Clipboard."
else
    notify-send -u critical -t 3000 "Screenshot" "Error saving screenshot."
fi
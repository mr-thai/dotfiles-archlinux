#!/bin/bash
SCREENSHOT_DIR=~/Pictures/Screenshots
mkdir -p "$SCREENSHOT_DIR"
SLURP_SELECT_ARGS="-b #1e1e2e44 -c #cba6f7ff -s #cba6f722 -w 2"

FILE="$SCREENSHOT_DIR/slurp_$(date +%Y%m%d_%H%M%S).png"
GEOMETRY=$(slurp $SLURP_SELECT_ARGS)

if [ -z "$GEOMETRY" ]; then
    notify-send -t 2000 "Screenshot" "Cancelled region selection."
    exit 0
fi

if grim -g "$GEOMETRY" "$FILE"; then
    swappy -f "$FILE" -o "$FILE"
    wl-copy -t image/png < "$FILE"
    notify-send -t 4000 "Region Screenshot" "Captured successfully!\nSaved to: $FILE\nCopied to Clipboard."
else
    notify-send -u critical -t 3000 "Screenshot" "Error: Could not capture selected region."
fi
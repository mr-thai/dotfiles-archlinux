#!/bin/bash
SCREENSHOT_DIR=~/Pictures/Screenshots
mkdir -p "$SCREENSHOT_DIR"
SLURP_WINDOW_ARGS="-b #1e1e2e44 -c #f5c2e7ff -s #f5c2e722 -w 2"

FILE="$SCREENSHOT_DIR/window_$(date +%Y%m%d_%H%M%S).png"
WINDOW_REGIONS=$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"')

if [ -z "$WINDOW_REGIONS" ]; then
    notify-send -u critical -t 3000 "Window Screenshot" "Error: Could not retrieve active window information."
    exit 1
fi

GEOMETRY=$(slurp $SLURP_WINDOW_ARGS <<< "$WINDOW_REGIONS")

if [ -z "$GEOMETRY" ]; then
    notify-send -t 2000 "Screenshot" "Cancelled window capture."
    exit 0
fi

if grim -g "$GEOMETRY" "$FILE"; then
    swappy -f "$FILE" -o "$FILE"
    wl-copy -t image/png < "$FILE"
    notify-send -t 4000 "Window Screenshot" "Captured successfully!\nSaved to: $FILE\nCopied to Clipboard."
else
    notify-send -u critical -t 3000 "Screenshot" "Error: Could not capture specified window."
fi
#!/bin/bash
notify-send -t 2000 "Color Picker" "Click anywhere to pick a color"

# Get coordinates with slurp, capture with grim, extract with ImageMagick
HEX=$(grim -g "$(slurp -p -b 00000000 -c 00000000)" -t png - | magick - -format '%[hex:p{0,0}]' info:- 2>/dev/null)

if [ -n "$HEX" ]; then
    HEX="#${HEX:0:6}"
    # Capitalize the hex code
    HEX=$(echo "$HEX" | tr '[:lower:]' '[:upper:]')
    echo -n "$HEX" | wl-copy
    notify-send -t 4000 "Color Picker" "Copied: $HEX" 
fi

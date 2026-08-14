#!/bin/bash
if command -v hyprpicker >/dev/null 2>&1; then
    COLOR=$(hyprpicker -a -f hex)
    [ -n "$COLOR" ] && notify-send "Color Picker" "Copied: $COLOR" -t 3000
else
    notify-send -u critical "Color Picker" "Vui lòng cài đặt: paru -S hyprpicker"
fi

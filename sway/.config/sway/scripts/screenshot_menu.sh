#!/bin/bash

if pgrep -f "gpu-screen-recorder" > /dev/null; then
    options="󰓛 Stop Recording
󰍹 Display
󰒉 Select
󰖲 Window
󰈚 OCR
󰏘 Color Picker"
    lines=6
else
    options="󰍹 Display
󰒉 Select
󰖲 Window
󰈚 OCR
󰏘 Color Picker
󰑋 Record Display
󰕧 Record Region"
    lines=7
fi

chosen=$(fuzzel --dmenu -a center -l $lines -w 25 -p "Screenshot/Record: " <<< "$options")

case "$chosen" in
    *Stop*)
        exec ~/.config/sway/scripts/actions/record_screen.sh stop
        ;;
    *Record*Display*)
        exec ~/.config/sway/scripts/actions/record_screen.sh display
        ;;
    *Record*Region*)
        exec ~/.config/sway/scripts/actions/record_screen.sh region
        ;;
    *Display*)
        exec ~/.config/sway/scripts/actions/screenshot_display.sh
        ;;
    *Select*)
        exec ~/.config/sway/scripts/actions/screenshot_select.sh
        ;;
    *Window*)
        exec ~/.config/sway/scripts/actions/screenshot_window.sh
        ;;
    *Color*Picker*)
        exec ~/.config/sway/scripts/actions/color_picker.sh
        ;;
    *OCR*)
        exec ~/.config/sway/scripts/actions/ocr_screenshot.sh
        ;;
esac

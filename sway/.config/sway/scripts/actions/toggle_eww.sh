#!/bin/bash

# Check if fcitx_hud OR practice_popup is open
if eww active-windows | grep -E "(fcitx_hud|practice_popup)" > /dev/null 2>&1; then
    eww close fcitx_hud practice_popup 2>/dev/null
else
    if ! eww ping >/dev/null 2>&1; then
        killall -q eww
        eww daemon &
        sleep 1
    fi

    eww open fcitx_hud
    eww open practice_popup 2>/dev/null

    sleep 0.2
    if ! eww active-windows | grep -E "fcitx_hud" > /dev/null 2>&1; then
        notify-send -t 2000 "Eww HUD" "UI error detected, auto-reloading..."
        killall -q eww
        eww daemon &
        sleep 1
        eww open fcitx_hud
        eww open practice_popup 2>/dev/null
    fi
fi

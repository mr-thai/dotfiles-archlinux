#!/bin/bash
APP="$1"
CMD="${2:-$1}"

if swaymsg -t get_tree | grep -iq "\"app_id\": \".*$APP.*\"\|\"class\": \".*$APP.*\""; then
    swaymsg "[app_id=\"(?i).*$APP.*\"] focus" 2>/dev/null
    swaymsg "[class=\"(?i).*$APP.*\"] focus" 2>/dev/null
else
    eval "$CMD" &
fi

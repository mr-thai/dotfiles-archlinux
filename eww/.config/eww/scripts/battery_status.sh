#!/usr/bin/env bash
cap=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo "100")
status=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null || echo "Unknown")

icon="󰁹"
class="normal"

if [[ "$status" == "Charging" ]]; then
    icon="󰂄"
    class="charging"
else
    if [ "$cap" -le 15 ]; then
        icon="󰁺"
        class="critical"
    elif [ "$cap" -le 30 ]; then
        icon="󰁼"
        class="warning"
    fi
fi

echo "{\"text\":\"$icon $cap%\", \"class\":\"$class\"}"

#!/bin/bash
exec >>/tmp/power_menu.log 2>&1
echo "--- Power Menu Triggered at $(date) ---"

SELECTION="$(printf "󰌾 Lock & Screen Off\n󰍃 Log out\n Reboot\n󰐥 Shutdown" | fuzzel --dmenu -a center -l 4 -w 20 -p "Power Menu: ")"
echo "SELECTION='$SELECTION'"

confirm_action() {
    local action="$1"
    echo "Prompting for action: $action"
    CONFIRMATION="$(printf "No\nYes" | fuzzel --dmenu -a center -l 5 -w 12 -p "$action?")"
    echo "CONFIRMATION='$CONFIRMATION'"
    [[ "$CONFIRMATION" == *"Yes"* ]]
}

case $SELECTION in

*"󰌾 Lock & Screen Off"*)
    pkill -USR1 swayidle
    ;;
*"󰍃 Log out"*)
    if confirm_action "Log out"; then
        echo "Executing swaymsg exit"
        swaymsg exit
    fi
    ;;
*" Reboot"*)
    if confirm_action "Reboot"; then
        systemctl reboot
    fi
    ;;
*"󰐥 Shutdown"*)
    if confirm_action "Shutdown"; then
        systemctl poweroff
    fi
    ;;
*)
    echo "No matching case for selection"
    ;;
esac


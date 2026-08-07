#!/bin/bash

# Switch to workspace 1
swaymsg 'workspace number 1'

# Check if foot or footclient is running
if swaymsg -t get_tree | jq -e '.. | objects | select(.app_id? == "footclient" or .app_id? == "foot")' > /dev/null; then
    # Focus the terminal
    swaymsg '[app_id="footclient"] focus' 2>/dev/null || swaymsg '[app_id="foot"] focus' 2>/dev/null
else
    # Launch terminal if not running
    swaymsg 'exec footclient'
fi

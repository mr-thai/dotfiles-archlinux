#!/bin/bash
echo "Workspace OSD script started at $(date)" >> /tmp/workspace_osd_debug.log

while true; do
    swaymsg -t subscribe -m '["workspace"]' | while read -r line; do
        WS=$(echo "$line" | jq -r 'select(.change == "focus") | .current.name' 2>/dev/null)
        
        if [ -n "$WS" ] && [ "$WS" != "null" ]; then
            echo "Changing to workspace $WS at $(date)" >> /tmp/workspace_osd_debug.log
            eww update current_workspace="$WS"
            eww open workspace_osd
            pkill -f "sleep 0.3; eww close workspace_osd"
            bash -c "sleep 0.3; eww close workspace_osd" &
        fi
    done
    
    sleep 1
done

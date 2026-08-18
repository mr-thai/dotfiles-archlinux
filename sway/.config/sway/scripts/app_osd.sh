#!/bin/bash
CACHE_FILE="$HOME/.cache/app_icons.json"
[ ! -f "$CACHE_FILE" ] && echo "{}" > "$CACHE_FILE"

swaymsg -t subscribe -m '["window"]' | while read -r line; do
    change=$(echo "$line" | jq -r '.change')
    if [ "$change" = "focus" ]; then
        app_id=$(echo "$line" | jq -r '.container.app_id // .container.window_properties.class' | tr '[:upper:]' '[:lower:]')
        
        [ -z "$app_id" ] || [ "$app_id" = "null" ] && continue
        
        # 1. Read the JSON cache
        icon_path=$(jq -r ".[\"$app_id\"]" "$CACHE_FILE" 2>/dev/null)
        
        # 2. If not cached yet
        if [ "$icon_path" = "null" ] || [ -z "$icon_path" ]; then
            desktop_file=$(find /usr/share/applications ~/.local/share/applications -maxdepth 2 -iname "*${app_id}*.desktop" 2>/dev/null | head -n 1)
            
            if [ -z "$desktop_file" ] && [[ "$app_id" == *.* ]]; then
                short_id="${app_id##*.}"
                desktop_file=$(find /usr/share/applications ~/.local/share/applications -maxdepth 2 -iname "*${short_id}*.desktop" 2>/dev/null | head -n 1)
            fi
            
            if [ -n "$desktop_file" ]; then
                icon_name=$(grep -E "^Icon=" "$desktop_file" | head -n 1 | cut -d'=' -f2 | tr -d '\r')
                if [[ "$icon_name" == /* ]]; then
                    icon_path="$icon_name"
                else
                    icon_path=$(find /usr/share/icons ~/.local/share/icons /usr/share/pixmaps -iname "${icon_name}.*" 2>/dev/null | grep -E "\.(png|svg)$" | head -n 1)
                fi
            fi
            
            tmp=$(mktemp)
            jq ". + {\"$app_id\": \"$icon_path\"}" "$CACHE_FILE" > "$tmp" && mv "$tmp" "$CACHE_FILE"
        fi
        
        # 3. Show the OSD if there is a valid icon path (file exists)
        if [ -n "$icon_path" ] && [ -f "$icon_path" ]; then
            eww update current_app_icon="$icon_path"
            eww open app_osd
            pkill -f "sleep 0.3; eww close app_osd"
            bash -c "sleep 0.3; eww close app_osd" &
        fi
    fi
done

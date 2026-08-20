#!/bin/bash
APP_ID="$1"
CMD="$2"
TARGET_OUTPUT="${3:-DP-1}"
TITLE_MATCH="$4"
[ -z "$APP_ID" ] || [ -z "$CMD" ] && exit 1

ACTIVE_OUTPUTS=$(swaymsg -t get_outputs -r | jq -r '.[].name')
if ! echo "$ACTIVE_OUTPUTS" | grep -q "^$TARGET_OUTPUT$"; then
    TARGET_OUTPUT=$(swaymsg -t get_outputs -r | jq -r '.[] | select(.focused) | .name')
fi

TREE=$(swaymsg -t get_tree)

WIN_JSON_ARRAY=$(echo "$TREE" | jq -c --arg app "$APP_ID" --arg title "$TITLE_MATCH" '[.. | objects | select(((.app_id != null and (.app_id | ascii_downcase | endswith($app | ascii_downcase))) or (.window_properties.class != null and (.window_properties.class | ascii_downcase | endswith($app | ascii_downcase)))) and ($title == "" or (.name != null and (.name | contains($title)))) and (.name != "Picture-in-Picture") and (.name != "Picture in picture")) | select(. != null) | {id, visible, focused, type: .window_properties.window_type, role: .window_properties.window_role}]')

if [ "$WIN_JSON_ARRAY" != "[]" ]; then
    ANY_VISIBLE=$(echo "$WIN_JSON_ARRAY" | jq -r '[.[].visible] | any')
    
    if [ "$ANY_VISIBLE" = "true" ]; then
        # HIDE
        CON_IDS=$(echo "$WIN_JSON_ARRAY" | jq -r '.[].id')
        for ID in $CON_IDS; do
            swaymsg "[con_id=$ID] move scratchpad"
        done
    else
        # SHOW
        CON_IDS=$(echo "$WIN_JSON_ARRAY" | jq -r '.[].id')
        
        TARGET_WS="current"
        
        for ID in $CON_IDS; do
            CMD_STR="[con_id=$ID] move workspace $TARGET_WS"
            
            case "$APP_ID" in
                "zen"|"firefox-developer-edition"|"firefox"|"obsidian"|"beekeeper-studio"|"bruno") CMD_STR="$CMD_STR, resize set width 90 ppt height 90 ppt, move position center" ;;
                "anki") CMD_STR="$CMD_STR, resize set width 75 ppt height 75 ppt, move position center" ;;
                "virt-manager") CMD_STR="$CMD_STR, resize set width 90 ppt height 80 ppt, move position center" ;;
                "scratchpad_nmtui") CMD_STR="$CMD_STR, resize set width 35 ppt height 60 ppt, move position center" ;;
                "scratchpad_pulsemixer") CMD_STR="$CMD_STR, resize set width 40 ppt height 50 ppt, move position center" ;;
            esac
            swaymsg "$CMD_STR"
        done
        
        if [ "$TARGET_WS" != "current" ]; then
            swaymsg "workspace $TARGET_WS"
        fi
        
        swaymsg "[app_id=\"$APP_ID\" window_type=\"dialog\"] focus" 2>/dev/null || true
        swaymsg "[app_id=\"$APP_ID\" window_role=\"pop-up\"] focus" 2>/dev/null || true
        swaymsg "[class=\"$APP_ID\" window_type=\"dialog\"] focus" 2>/dev/null || true
        swaymsg "[class=\"$APP_ID\" window_role=\"pop-up\"] focus" 2>/dev/null || true
        swaymsg "[con_id=$(echo "$CON_IDS" | tail -n 1)] focus" 2>/dev/null || true
    fi
else
    swaymsg "focus output $TARGET_OUTPUT"
    eval "$CMD" &
    
    # Try to find it immediately (for fast-launching apps like foot)
    sleep 0.1
    TREE=$(swaymsg -t get_tree)
    CON_ID=$(echo "$TREE" | jq -r --arg app "$APP_ID" --arg title "$TITLE_MATCH" '[.. | objects | select(((.app_id != null and (.app_id | ascii_downcase | endswith($app | ascii_downcase))) or (.window_properties.class != null and (.window_properties.class | ascii_downcase | endswith($app | ascii_downcase)))) and ($title == "" or (.name != null and (.name | contains($title)))) and (.name != "Picture-in-Picture") and (.name != "Picture in picture"))] | .[0].id // empty')
    
    if [ -z "$CON_ID" ]; then
        timeout 5 swaymsg -t subscribe -m '["window"]' | jq --unbuffered -e --arg app "$APP_ID" --arg title "$TITLE_MATCH" '. | select(.change == "new") | select(((.container.app_id != null and (.container.app_id | ascii_downcase | endswith($app | ascii_downcase))) or (.container.window_properties.class != null and (.container.window_properties.class | ascii_downcase | endswith($app | ascii_downcase)))) and ($title == "" or (.container.name != null and (.container.name | contains($title)))) and (.container.name != "Picture-in-Picture") and (.container.name != "Picture in picture"))' | head -n 1 >/dev/null
        TREE=$(swaymsg -t get_tree)
        CON_ID=$(echo "$TREE" | jq -r --arg app "$APP_ID" --arg title "$TITLE_MATCH" '[.. | objects | select(((.app_id != null and (.app_id | ascii_downcase | endswith($app | ascii_downcase))) or (.window_properties.class != null and (.window_properties.class | ascii_downcase | endswith($app | ascii_downcase)))) and ($title == "" or (.name != null and (.name | contains($title)))) and (.name != "Picture-in-Picture") and (.name != "Picture in picture"))] | .[0].id // empty')
    fi
    
    if [ -n "$CON_ID" ]; then
        TARGET_WS="current"
        CMD_STR="[con_id=$CON_ID] move workspace $TARGET_WS, workspace $TARGET_WS, focus"
        case "$APP_ID" in
            "zen"|"firefox-developer-edition"|"firefox"|"obsidian"|"beekeeper-studio"|"bruno") CMD_STR="$CMD_STR, resize set width 90 ppt height 90 ppt, move position center" ;;
            "anki") CMD_STR="$CMD_STR, resize set width 75 ppt height 75 ppt, move position center" ;;
            "virt-manager") CMD_STR="$CMD_STR, resize set width 90 ppt height 80 ppt, move position center" ;;
            "scratchpad_nmtui") CMD_STR="$CMD_STR, resize set width 35 ppt height 60 ppt, move position center" ;;
            "scratchpad_pulsemixer") CMD_STR="$CMD_STR, resize set width 40 ppt height 50 ppt, move position center" ;;
            "scratchpad_term") CMD_STR="$CMD_STR, resize set width 100 ppt height 35 ppt, move position 0 0" ;;
        esac
        swaymsg "$CMD_STR"
    fi
fi

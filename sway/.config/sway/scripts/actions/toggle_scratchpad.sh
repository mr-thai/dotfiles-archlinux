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

# Lấy mảng JSON chứa tất cả các cửa sổ thuộc về APP_ID này
WIN_JSON_ARRAY=$(echo "$TREE" | jq -c --arg app "$APP_ID" --arg title "$TITLE_MATCH" '[.. | objects | select(((.app_id != null and (.app_id | ascii_downcase | endswith($app | ascii_downcase))) or (.window_properties.class != null and (.window_properties.class | ascii_downcase | endswith($app | ascii_downcase)))) and ($title == "" or (.name != null and (.name | contains($title)))) and (.name != "Picture-in-Picture") and (.name != "Picture in picture")) | select(. != null) | {id, visible, focused, type: .window_properties.window_type, role: .window_properties.window_role}]')

if [ "$WIN_JSON_ARRAY" != "[]" ]; then
    # Kiểm tra xem có bất kỳ cửa sổ nào của app đang nằm trên màn hình không
    ANY_VISIBLE=$(echo "$WIN_JSON_ARRAY" | jq -r '[.[].visible] | any')
    
    if [ "$ANY_VISIBLE" = "true" ]; then
        # CẤT ĐI: Cất toàn bộ các cửa sổ (cả main lẫn pop-up) vào scratchpad cùng một lúc
        CON_IDS=$(echo "$WIN_JSON_ARRAY" | jq -r '.[].id')
        for ID in $CON_IDS; do
            swaymsg "[con_id=$ID] move scratchpad"
        done
    else
        # GỌI RA: Móc toàn bộ các cửa sổ (cả main lẫn pop-up) ra màn hình hiện tại cùng một lúc
        CON_IDS=$(echo "$WIN_JSON_ARRAY" | jq -r '.[].id')
        
        TARGET_WS="current"
        
        for ID in $CON_IDS; do
            CMD_STR="[con_id=$ID] move workspace $TARGET_WS"
            
            # Lưu ý: Việc resize sẽ áp dụng lên tất cả, nhưng nhờ Sway rules mới thêm, popup sẽ tự trồi lên
            case "$APP_ID" in
                "zen"|"firefox-developer-edition"|"firefox"|"obsidian"|"dbeaver"|"bruno") CMD_STR="$CMD_STR, resize set width 90 ppt height 90 ppt, move position center" ;;
                "anki") CMD_STR="$CMD_STR, resize set width 75 ppt height 75 ppt, move position center" ;;
                "sys_dashboard"|"virt-manager") CMD_STR="$CMD_STR, resize set width 90 ppt height 80 ppt, move position center" ;;
                "scratchpad_nmtui") CMD_STR="$CMD_STR, resize set width 35 ppt height 60 ppt, move position center" ;;
                "scratchpad_pulsemixer"|"scratchpad_bluetui"|"scratchpad_rmpc") CMD_STR="$CMD_STR, resize set width 40 ppt height 50 ppt, move position center" ;;
            esac
            swaymsg "$CMD_STR"
        done
        
        if [ "$TARGET_WS" != "current" ]; then
            swaymsg "workspace $TARGET_WS"
        fi
        
        # Ép Focus lại các cửa sổ Pop-up/Dialog để chúng nhảy lên trên cùng
        swaymsg "[app_id=\"$APP_ID\" window_type=\"dialog\"] focus" 2>/dev/null || true
        swaymsg "[app_id=\"$APP_ID\" window_role=\"pop-up\"] focus" 2>/dev/null || true
        swaymsg "[class=\"$APP_ID\" window_type=\"dialog\"] focus" 2>/dev/null || true
        swaymsg "[class=\"$APP_ID\" window_role=\"pop-up\"] focus" 2>/dev/null || true
        # Dự phòng ép focus cái cửa sổ vừa xuất hiện cuối cùng
        swaymsg "[con_id=$(echo "$CON_IDS" | tail -n 1)] focus" 2>/dev/null || true
    fi
else
    # Mở app mới nếu chưa tồn tại
    swaymsg "focus output $TARGET_OUTPUT"
    eval "$CMD" &
    
    timeout 15 swaymsg -t subscribe -m '["window"]' | jq --unbuffered -e --arg app "$APP_ID" --arg title "$TITLE_MATCH" '. | select(.change == "new") | select(((.container.app_id != null and (.container.app_id | ascii_downcase | endswith($app | ascii_downcase))) or (.container.window_properties.class != null and (.container.window_properties.class | ascii_downcase | endswith($app | ascii_downcase)))) and ($title == "" or (.container.name != null and (.container.name | contains($title)))) and (.container.name != "Picture-in-Picture") and (.container.name != "Picture in picture"))' | head -n 1 >/dev/null
    
    TREE=$(swaymsg -t get_tree)
    CON_ID=$(echo "$TREE" | jq -r --arg app "$APP_ID" --arg title "$TITLE_MATCH" '[.. | objects | select(((.app_id != null and (.app_id | ascii_downcase | endswith($app | ascii_downcase))) or (.window_properties.class != null and (.window_properties.class | ascii_downcase | endswith($app | ascii_downcase)))) and ($title == "" or (.name != null and (.name | contains($title)))) and (.name != "Picture-in-Picture") and (.name != "Picture in picture"))] | .[0].id // empty')
    
    if [ -n "$CON_ID" ]; then
        TARGET_WS="current"
        CMD_STR="[con_id=$CON_ID] move workspace $TARGET_WS, workspace $TARGET_WS, focus"
        case "$APP_ID" in
            "zen"|"firefox-developer-edition"|"firefox"|"obsidian"|"dbeaver"|"bruno") CMD_STR="$CMD_STR, resize set width 90 ppt height 90 ppt, move position center" ;;
            "anki") CMD_STR="$CMD_STR, resize set width 75 ppt height 75 ppt, move position center" ;;
            "sys_dashboard"|"virt-manager") CMD_STR="$CMD_STR, resize set width 90 ppt height 80 ppt, move position center" ;;
            "scratchpad_nmtui") CMD_STR="$CMD_STR, resize set width 35 ppt height 60 ppt, move position center" ;;
            "scratchpad_pulsemixer"|"scratchpad_bluetui"|"scratchpad_rmpc") CMD_STR="$CMD_STR, resize set width 40 ppt height 50 ppt, move position center" ;;
        esac
        swaymsg "$CMD_STR"
    fi
fi

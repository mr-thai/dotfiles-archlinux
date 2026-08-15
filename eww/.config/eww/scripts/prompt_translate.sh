#!/bin/bash

ACTION=$1

if [ "$ACTION" = "start" ]; then
    SOURCE_LANG=$2
    TARGET_LANG=$3
    TITLE=$4
    APP_ID=$5
    KBD_LAYOUT=$6
    STATUS_LBL=$7
    PROMPT_TEXT=$8
    
    foot --app-id="$APP_ID" -T "$TITLE" -W 60x3 ~/.config/eww/scripts/prompt_translate.sh run "$TARGET_LANG" "$KBD_LAYOUT" "$STATUS_LBL" "$PROMPT_TEXT"
    exit 0
fi

if [ "$ACTION" = "run" ]; then
    TARGET_LANG=$2
    KBD_LAYOUT=$3
    STATUS_LBL=$4
    PROMPT_TEXT=$5

    sleep 0.1
    if [ -n "$KBD_LAYOUT" ]; then
        fcitx5-remote -s "$KBD_LAYOUT"
    fi

    echo ""
    read -e -p "  📝 $PROMPT_TEXT: " INPUT_TEXT

    if [ -z "$INPUT_TEXT" ]; then exit 0; fi

    TIMER_PID="/tmp/detail_popup_timer.pid"
    if [ -f "$TIMER_PID" ]; then
        kill "$(cat "$TIMER_PID")" 2>/dev/null
        rm -f "$TIMER_PID"
    fi

    eww update detail_source="$INPUT_TEXT" detail_result="⏳ Translating..." detail_status="$STATUS_LBL"
    eww open detail_popup 2>/dev/null || true

    # Đọc API Key bảo mật từ file cục bộ hoặc biến môi trường
    KEY_FILE="$HOME/.config/deepl/api_key"
    if [ -n "$DEEPL_API_KEY" ]; then
        DEEPL_KEY="$DEEPL_API_KEY"
    elif [ -f "$KEY_FILE" ]; then
        DEEPL_KEY=$(cat "$KEY_FILE" | tr -d '[:space:]')
    else
        DEEPL_KEY="2999ff54-b53b-42fd-b2a4-25f0a202ab7d:fx" # Fallback
    fi
    JSON_PAYLOAD=$(jq -n --arg text "$INPUT_TEXT" --arg target "$TARGET_LANG" '{text: [$text], target_lang: $target}')

    RESPONSE=$(timeout 5s curl -s -X POST 'https://api-free.deepl.com/v2/translate' \
        -H "Authorization: DeepL-Auth-Key $DEEPL_KEY" \
        -H "Content-Type: application/json" \
        -d "$JSON_PAYLOAD")

    if [ $? -eq 124 ]; then
        OUT_TEXT="⏳ Timeout."
    else
        OUT_TEXT=$(echo "$RESPONSE" | jq -r '.translations[0].text // empty')
        if [ -z "$OUT_TEXT" ] || [ "$OUT_TEXT" = "null" ]; then
            OUT_TEXT="❌ Network error or API limit reached."
        fi
    fi

    # Hiragana translation logic for Japanese target
    if [ "$TARGET_LANG" = "JA" ] && [ -n "$OUT_TEXT" ] && [ "$OUT_TEXT" != "⏳ Timeout." ] && [[ "$OUT_TEXT" != *"❌"* ]]; then
        if command -v kakasi &> /dev/null; then
            HIRAGANA=$(echo "$OUT_TEXT" | kakasi -i utf8 -o utf8 -JH 2>/dev/null | tr -d '\n')
            OUT_TEXT="$OUT_TEXT ($HIRAGANA)"
        fi
    fi

    eww update detail_result="$OUT_TEXT"

    HIST_FILE="$HOME/.local/share/trans_history.tsv"
    mkdir -p "$(dirname "$HIST_FILE")"
    [ -n "$OUT_TEXT" ] && printf '%s\t%s\t%s\t%s\n' \
        "$(date '+%Y-%m-%d %H:%M')" "$STATUS_LBL" "$INPUT_TEXT" "$OUT_TEXT" >> "$HIST_FILE"

    # Lưu bản dịch làm giá trị clipboard chính thức
    if [ -n "$OUT_TEXT" ] && [ "$OUT_TEXT" != "⏳ Timeout." ] && [[ "$OUT_TEXT" != *"❌"* ]]; then
        printf '%s' "$OUT_TEXT" | wl-copy
    fi

    (sleep 30 && eww close detail_popup 2>/dev/null) &
    echo $! > "$TIMER_PID"
fi

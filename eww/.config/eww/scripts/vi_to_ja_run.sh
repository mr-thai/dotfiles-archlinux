#!/bin/bash
sleep 0.1
fcitx5-remote -s bamboo
echo ""
read -e -p "  📝 Vietnamese: " SRC_TEXT
if [ -z "$SRC_TEXT" ]; then exit 0; fi

TIMER_PID="/tmp/detail_popup_timer.pid"
if [ -f "$TIMER_PID" ]; then
    kill "$(cat "$TIMER_PID")" 2>/dev/null
    rm -f "$TIMER_PID"
fi

eww update detail_source="$SRC_TEXT" detail_result="⏳ Translating..." detail_status="󰚩 VI → JA"
eww open detail_popup 2>/dev/null || true

DEEPL_KEY="2999ff54-b53b-42fd-b2a4-25f0a202ab7d:fx"
JSON_PAYLOAD=$(jq -n --arg text "$SRC_TEXT" --arg target "JA" '{text: [$text], target_lang: $target}')
RESPONSE=$(timeout 5s curl -s -X POST 'https://api-free.deepl.com/v2/translate' \
    -H "Authorization: DeepL-Auth-Key $DEEPL_KEY" \
    -H "Content-Type: application/json" \
    -d "$JSON_PAYLOAD")

if [ $? -eq 124 ]; then
    DST_TEXT="⏳ Timeout."
else
    DST_TEXT=$(echo "$RESPONSE" | jq -r '.translations[0].text // empty')
    if [ -z "$DST_TEXT" ] || [ "$DST_TEXT" = "null" ]; then
        DST_TEXT="❌ Network error or API limit reached."
    fi
fi

if [ -n "$DST_TEXT" ] && [ "$DST_TEXT" != "⏳ Timeout." ] && [[ "$DST_TEXT" != *"❌"* ]]; then
    if command -v kakasi &> /dev/null; then
        HIRAGANA=$(echo "$DST_TEXT" | kakasi -i utf8 -o utf8 -JH 2>/dev/null | tr -d '\n')
        DST_TEXT="$DST_TEXT ($HIRAGANA)"
    fi
fi

eww update detail_result="$DST_TEXT"

HIST_FILE="$HOME/.local/share/trans_history.tsv"
mkdir -p "$(dirname "$HIST_FILE")"
[ -n "$DST_TEXT" ] && printf '%s\t%s\t%s\t%s\n' \
    "$(date '+%Y-%m-%d %H:%M')" "VI→JA" "$SRC_TEXT" "$DST_TEXT" >> "$HIST_FILE"

if [ -n "$DST_TEXT" ] && [ "$DST_TEXT" != "⏳ Timeout." ] && [[ "$DST_TEXT" != *"❌"* ]]; then
    printf '%s' "$DST_TEXT" | wl-copy
    sleep 0.5
    printf '%s' "$SRC_TEXT" | wl-copy
fi

(sleep 30 && eww close detail_popup 2>/dev/null) &
echo $! > "$TIMER_PID"

#!/bin/bash

sleep 0.1
fcitx5-remote -s keyboard-us

echo ""
read -e -p "  📝 English: " ENG_TEXT

if [ -z "$ENG_TEXT" ]; then exit 0; fi

# ── Reset auto-close timer ──────────────────────────────────────────────────
TIMER_PID="/tmp/detail_popup_timer.pid"
if [ -f "$TIMER_PID" ]; then
    kill "$(cat "$TIMER_PID")" 2>/dev/null
    rm -f "$TIMER_PID"
fi

eww update detail_source="$ENG_TEXT" detail_result="⏳ Translating..." detail_status="󰚩 EN → VI"
eww open detail_popup 2>/dev/null || true

# Translate using DeepL API
DEEPL_KEY="2999ff54-b53b-42fd-b2a4-25f0a202ab7d:fx"
JSON_PAYLOAD=$(jq -n --arg text "$ENG_TEXT" --arg target "VI" '{text: [$text], target_lang: $target}')

RESPONSE=$(timeout 5s curl -s -X POST 'https://api-free.deepl.com/v2/translate' \
    -H "Authorization: DeepL-Auth-Key $DEEPL_KEY" \
    -H "Content-Type: application/json" \
    -d "$JSON_PAYLOAD")

if [ $? -eq 124 ]; then
    VI_TEXT="⏳ Timeout."
else
    VI_TEXT=$(echo "$RESPONSE" | jq -r '.translations[0].text // empty')
    if [ -z "$VI_TEXT" ] || [ "$VI_TEXT" = "null" ]; then
        VI_TEXT="❌ Network error or API limit reached."
    fi
fi

eww update detail_result="$VI_TEXT"

# ── Save to history & clipboard ─────────────────────────────────────────────
HIST_FILE="$HOME/.local/share/trans_history.tsv"
mkdir -p "$(dirname "$HIST_FILE")"
[ -n "$VI_TEXT" ] && printf '%s\t%s\t%s\t%s\n' \
    "$(date '+%Y-%m-%d %H:%M')" "EN→VI" "$ENG_TEXT" "$VI_TEXT" >> "$HIST_FILE"

if [ -n "$VI_TEXT" ] && [ "$VI_TEXT" != "⏳ Timeout." ] && [[ "$VI_TEXT" != *"❌"* ]]; then
    printf '%s' "$VI_TEXT" | wl-copy
    sleep 0.5
    printf '%s' "$ENG_TEXT" | wl-copy
fi

# ── Start fresh 30s auto-close timer ───────────────────────────────────────
(sleep 30 && eww close detail_popup 2>/dev/null) &
echo $! > "$TIMER_PID"

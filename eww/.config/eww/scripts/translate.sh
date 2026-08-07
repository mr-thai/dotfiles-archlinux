#!/bin/bash

# Kill old translation processes
for pid in $(pgrep -f "translate.sh"); do
    if [ $pid != $$ ]; then
        kill -9 $pid 2>/dev/null
    fi
done

# ── Reset auto-close timer ──────────────────────────────────────────────────
TIMER_PID="/tmp/detail_popup_timer.pid"
if [ -f "$TIMER_PID" ]; then
    kill "$(cat "$TIMER_PID")" 2>/dev/null
    rm -f "$TIMER_PID"
fi

# Try to get from primary clipboard (highlight with mouse)
TEXT=$(wl-paste -p -n 2>/dev/null)

# If empty, try standard clipboard (Zellij / Neovim y)
if [ -z "$TEXT" ]; then
    TEXT=$(wl-paste -n 2>/dev/null)
fi

if [ -z "$TEXT" ]; then exit 0; fi

# Limit to 1000 characters, clean up newlines
TEXT=${TEXT:0:1000}
TEXT=$(echo "$TEXT" | tr '\n' ' ' | sed -e 's/  */ /g' | xargs)

# Auto-detect language direction via trans -id
LANG_ID=$(timeout 3s trans -id "$TEXT" 2>/dev/null | head -1)

if echo "$LANG_ID" | grep -qi "Vietnamese"; then
    TARGET="EN-US"
    STATUS_LABEL="󰚩 VI → EN"
else
    TARGET="VI"
    STATUS_LABEL="󰚩 EN → VI"
fi

# Show loading state
eww update detail_source="$TEXT" detail_result="⏳ Translating..." detail_status="$STATUS_LABEL"
eww open detail_popup 2>/dev/null || true

# Translate using DeepL API
DEEPL_KEY="2999ff54-b53b-42fd-b2a4-25f0a202ab7d:fx"
JSON_PAYLOAD=$(jq -n --arg text "$TEXT" --arg target "$TARGET" '{text: [$text], target_lang: $target}')

RESPONSE=$(timeout 5s curl -s -X POST 'https://api-free.deepl.com/v2/translate' \
    -H "Authorization: DeepL-Auth-Key $DEEPL_KEY" \
    -H "Content-Type: application/json" \
    -d "$JSON_PAYLOAD")

if [ $? -eq 124 ]; then
    MEANING="⏳ Timeout."
else
    MEANING=$(echo "$RESPONSE" | jq -r '.translations[0].text // empty')
    if [ -z "$MEANING" ] || [ "$MEANING" = "null" ]; then
        MEANING="❌ Network error or API limit reached."
    fi
fi

eww update detail_result="$MEANING" detail_status="$STATUS_LABEL"

# ── Save to history ─────────────────────────────────────────────────────────
HIST_FILE="$HOME/.local/share/trans_history.tsv"
mkdir -p "$(dirname "$HIST_FILE")"
[ -n "$MEANING" ] && printf '%s\t%s\t%s\t%s\n' \
    "$(date '+%Y-%m-%d %H:%M')" "$STATUS_LABEL" "$TEXT" "$MEANING" >> "$HIST_FILE"

# ── Start fresh 15s auto-close timer ───────────────────────────────────────
(sleep 15 && eww close detail_popup 2>/dev/null) &
echo $! > "$TIMER_PID"

#!/bin/bash
# Every-hour timeline prompt: asks what you're doing, appends to TimeLine.md
set -e

LOG="/home/mr-thai/ObsidianDrive/Obsidian_Backup/90 System/TimeLine.md"
DATE=$(date '+%Y-%m-%d')
TIME=$(date '+%H:%M')

if [ "$1" = "open" ]; then
    # Launch the input prompt in a floating foot window (from systemd timer)
    footclient --app-id="timelog_input" -T "Timeline" -W 90x4 bash "$0" run 2>/dev/null \
        || foot --app-id="timelog_input" -T "Timeline" -W 90x4 bash "$0" run
    exit 0
fi

# --- run mode: show prompt and log ---
echo ""
echo "  [ $DATE $TIME ] What are you doing now?"
echo ""
read -e -p "  > " ACTIVITY

if [ -z "$ACTIVITY" ]; then
    echo ""
    echo "  (empty - nothing logged)"
    sleep 1.5
    exit 0
fi

# Backup the last line to avoid conflict with the empty template row if unmodified
if [ ! -s "$LOG" ]; then
    mkdir -p "$(dirname "$LOG")"
    printf '| Time | công việc đang làm tại thời gian đó chi tiết |\n| ---- | -------------------------------------------- |\n' > "$LOG"
fi

# Append the row
printf '| %s %s | %s |\n' "$DATE" "$TIME" "$ACTIVITY" >> "$LOG"

echo ""
echo "  Saved to TimeLine.md"
sleep 1.5
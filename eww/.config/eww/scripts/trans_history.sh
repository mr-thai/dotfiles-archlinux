#!/bin/bash

HIST_FILE="$HOME/.local/share/trans_history.tsv"

if [ ! -f "$HIST_FILE" ] || [ ! -s "$HIST_FILE" ]; then
    echo ""
    echo "  󰋊 No translation history yet."
    echo "  Use Mod+d, Mod+e, or Mod+Shift+e to translate."
    echo ""
    read -r -p "  Press Enter to close..." _
    exit 0
fi

# Show history newest first via fzf (tab-separated: date, dir, source, result)
SELECTED=$(tac "$HIST_FILE" | fzf \
    --reverse \
    --prompt="  󰋊 History › " \
    --header="Enter: Show  |  Ctrl-Y: Copy  |  Shift-Up/Down: Scroll preview  |  Esc: Close" \
    --delimiter=$'\t' \
    --with-nth=1,2,3 \
    --preview='printf "Source:\n  {3}\n\nResult:\n  {4}"' \
    --preview-window=up:6:wrap \
    --bind="ctrl-y:execute-silent(echo -n {4} | wl-copy),shift-up:preview-page-up,shift-down:preview-page-down,ctrl-up:preview-up,ctrl-down:preview-down" \
    --color="bg+:#313244,bg:#1e1e2e,hl:#f38ba8,fg:#cdd6f4,\
header:#a6adc8,info:#cba6f7,pointer:#f5e0dc,prompt:#cba6f7,\
hl+:#f38ba8,border:#45475a,preview-bg:#181825")

if [ -n "$SELECTED" ]; then
    DIR=$(printf '%s' "$SELECTED" | cut -f2)
    SRC=$(printf '%s' "$SELECTED" | cut -f3)
    RES=$(printf '%s' "$SELECTED" | cut -f4)

    # Show in detail_popup
    eww update detail_source="$SRC" detail_result="$RES" detail_status="󰋊 $DIR"
    eww open detail_popup 2>/dev/null || true

    # Reset auto-close timer (30s for history, more time to read)
    TIMER_PID="/tmp/detail_popup_timer.pid"
    [ -f "$TIMER_PID" ] && kill "$(cat "$TIMER_PID")" 2>/dev/null
    (sleep 30 && eww close detail_popup 2>/dev/null) &
    echo $! > "$TIMER_PID"
fi

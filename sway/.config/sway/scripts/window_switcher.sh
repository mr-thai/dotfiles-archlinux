#!/bin/bash
# ==============================================================================
# SMART WINDOW SWITCHER v2 — Nerd Font Icons + Scratchpad + XWayland
# ==============================================================================



# --- Truncate string to length, appending ellipsis if needed ---
trunc() {
    local s="$1" len="$2"
    if (( ${#s} > len )); then
        printf "%s…" "${s:0:$((len-1))}"
    else
        printf "%-${len}s" "$s"
    fi
}

# --- Fetch all windows from Sway tree via jq ---
# Output TSV: focused_sort  ws_sort  ws_label  app_id  title  con_id
raw=$(swaymsg -t get_tree | jq -r '
    def get_app:
        (.app_id // .window_properties.class // "xwayland");

    def extract($ws_label; $ws_sort; $is_scratch):
        (.. | objects)
        | select(.type == "con" or .type == "floating_con")
        | select((get_app) != null and (get_app) != "")
        | select(.name != null)
        | [
            (if .focused then "0" else "1" end),
            ($ws_sort | tostring),
            $ws_label,
            get_app,
            (.name | gsub("\t"; " ")),
            (.id | tostring)
          ]
        | join("\t");

    [
        # Regular workspaces
        ((.. | objects)
            | select(.type == "workspace" and .name != "__i3_scratch") as $ws
            | extract($ws.name; ($ws.num // 99); false)),

        # Scratchpad (__i3_scratch)
        ((.. | objects)
            | select(.name == "__i3_scratch")
            | extract("S"; 100; true))
    ]
    | unique
    | sort
    | .[]
')

# --- Build formatted display lines ---
output=""
while IFS=$'\t' read -r fsort _wsort ws app_id name id; do
    mark=$([ "$fsort" = "0" ] && echo "*" || echo " ")
    ws_col=$(printf "[%-2s]" "$ws")
    app_col=$(trunc "$app_id" 12)
    title_col=$(trunc "$name" 25)

    output+="${mark}${ws_col}  ${app_col}  ${title_col} (${id})"$'\n'
done <<< "$raw"

if [ -z "$output" ]; then
    notify-send "Window Switcher" "No window found." -t 2000
    exit 0
fi

# --- Show in fuzzel ---
row=$(printf "%s" "$output" | fuzzel --dmenu \
    --width=55 \
    --lines=8 \
    --font="JetBrainsMono Nerd Font:size=10" \
    --prompt="󰖯  Window: " \
    --placeholder="Search by app name or title…")
exit_code=$?

# --- Focus selected window ---
if [ -n "$row" ]; then
    winid="${row##*(}"
    winid="${winid%%)*}"
    
    if [ "$exit_code" -eq 10 ]; then
        swaymsg "[con_id=$winid] move scratchpad"
    else
        swaymsg "[con_id=$winid] focus" || \
        swaymsg "[con_id=$winid] scratchpad show"
    fi
fi

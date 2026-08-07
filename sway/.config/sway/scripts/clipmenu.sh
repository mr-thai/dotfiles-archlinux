#!/usr/bin/env bash

# ==============================================================================
# PREVIEW FUNCTION (CALLED BY FZF)
# ==============================================================================
if [[ "$1" == "preview" ]]; then
    id=$(echo "$2" | awk '{print $1}')
    
    if echo "$2" | grep -q '\[\[ binary data'; then
        cliphist decode "$id" | chafa -f sixel -s 40x40 - 2>/dev/null
    else
        cliphist decode "$id" | head -n 100
    fi
    exit 0
fi

# ==============================================================================
# MAIN INTERFACE (GUI MODE)
# ==============================================================================
if [[ "$1" == "gui" ]]; then
    export FZF_DEFAULT_OPTS="
      --height=100%
      --layout=reverse
      --border=none
      --prompt='󰅍 Clipboard: '
      --pointer='❯'
      --marker='✓'
      --info=inline
      --preview-window=right:55%:wrap
      --color=bg+:#313244,bg:#1e1e2e,spinner:#f5c2e7,hl:#f38ba8 \
      --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5c2e7 \
      --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
      --bind 'ctrl-d:execute(echo {} | awk \"{print \$1}\" | cliphist delete)+reload(cliphist list)'
      --bind 'ctrl-i:reload(cliphist list | grep \"\[\[ binary data\")+change-prompt( Images: )'
      --bind 'ctrl-t:reload(cliphist list | grep -v \"\[\[ binary data\")+change-prompt(󰦨 Text: )'
      --bind 'ctrl-r:reload(cliphist list)+change-prompt(󰅍 Clipboard: )'
    "
    
    entries=$(cliphist list 2>/dev/null)
    
    if [[ -z "$entries" ]]; then
        echo "Clipboard history is empty."
        sleep 1
        exit 0
    fi
    
    header_text="[Enter] Paste | [Ctrl-D] Delete | Filter: [Ctrl-I] Images, [Ctrl-T] Text, [Ctrl-R] All"
    
    selected=$(echo "$entries" | fzf \
        --header="$header_text" \
        --preview "$0 preview {}")
        
    if [[ -n "$selected" ]]; then
        id=$(echo "$selected" | awk '{print $1}')
        
        cliphist decode "$id" | wl-copy
        
        if command -v wtype >/dev/null 2>&1; then
            (sleep 0.3 && wtype -M ctrl -k v -m ctrl) &
        fi
    fi
else
    # ==============================================================================
    # SWAY HOTKEY TRIGGER
    # ==============================================================================
    footclient --app-id="clipmenu" -e "$0" gui
fi
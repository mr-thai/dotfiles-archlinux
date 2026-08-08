#!/bin/bash
APP="$1"
CMD="${2:-$1}"

# Tìm xem cửa sổ có tồn tại trong cây thư mục Sway không (không phân biệt hoa thường và tìm chuỗi con)
if swaymsg -t get_tree | grep -iq "\"app_id\": \".*$APP.*\"\|\"class\": \".*$APP.*\""; then
    # Nếu có, lập tức nhảy tới Workspace chứa nó và focus bằng substring regex
    swaymsg "[app_id=\"(?i).*$APP.*\"] focus" 2>/dev/null
    swaymsg "[class=\"(?i).*$APP.*\"] focus" 2>/dev/null
else
    # Nếu chưa có, mở app
    eval "$CMD" &
fi

#!/bin/bash

# Kiểm tra và khởi động Eww Daemon nếu chưa chạy
if ! eww ping >/dev/null 2>&1; then
    eww daemon &
    sleep 0.5
fi

# Toggle popup chi tiết dịch thuật hoặc thông tin hệ thống
if eww active-windows | grep -q "detail_popup"; then
    eww close detail_popup
else
    notify-send -t 1500 "Eww Status" "Eww daemon is active & healthy"
fi

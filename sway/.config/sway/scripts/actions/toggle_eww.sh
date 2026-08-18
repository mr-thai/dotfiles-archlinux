#!/bin/bash

if ! eww ping >/dev/null 2>&1; then
    eww daemon &
    sleep 0.5
fi

if eww active-windows | grep -q "detail_popup"; then
    eww close detail_popup
else
    notify-send -t 1500 "Eww Status" "Eww daemon is active & healthy"
fi

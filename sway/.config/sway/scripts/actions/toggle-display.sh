#!/bin/bash

CURRENT_X=$(swaymsg -t get_outputs | jq -r '.[] | select(.name=="DP-1") | .rect.x')

if [ "$CURRENT_X" = "1920" ]; then
  swaymsg output DP-1 pos 0 0
  swaymsg output eDP-1 pos 0 0
else
  swaymsg output DP-1 pos 1920 1080
  swaymsg output eDP-1 pos 0 0
fi

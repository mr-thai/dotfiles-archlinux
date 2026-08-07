#!/bin/bash
foot --app-id="vi_to_zh_input" -T "Vietnamese → Chinese" -W 60x3 ~/.config/eww/scripts/vi_to_zh_run.sh

sleep 0.1
fcitx5-remote -s keyboard-us

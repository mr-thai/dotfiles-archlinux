#!/bin/bash
foot --app-id="ja_to_vi_input" -T "Japanese → Vietnamese" -W 60x3 ~/.config/eww/scripts/ja_to_vi_run.sh

sleep 0.1
fcitx5-remote -s keyboard-us

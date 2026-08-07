#!/bin/bash
foot --app-id="zh_to_vi_input" -T "Chinese → Vietnamese" -W 60x3 ~/.config/eww/scripts/zh_to_vi_run.sh

sleep 0.1
fcitx5-remote -s keyboard-us

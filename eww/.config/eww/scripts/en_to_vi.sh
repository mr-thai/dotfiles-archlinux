#!/bin/bash

foot --app-id="en_to_vi_input" -T "English → Vietnamese" -W 60x3 ~/.config/eww/scripts/en_to_vi_run.sh

sleep 0.1
fcitx5-remote -s keyboard-us

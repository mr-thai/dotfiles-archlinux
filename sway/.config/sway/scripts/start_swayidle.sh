#!/bin/bash
# swayidle script - da sua de khong dung dpms off voi NVIDIA Optimus
# NGUYEN NHAN Xid79: "output * dpms off" tat dien GPU -> GPU_IS_LOST
pkill -x swayidle

swayidle -w \
     before-sleep "$HOME/.config/sway/scripts/smart_lock.sh" &

# NOTE: DA XOA "timeout 1200 'swaymsg output * dpms off'"
# Lenh nay tat man hinh nhung cung tat dien GPU NVIDIA qua S2idle
# Gay ra Xid Error 79 "GPU fallen off the bus"
# Neu muon tat man hinh: dung "brightnessctl set 0%" thay the

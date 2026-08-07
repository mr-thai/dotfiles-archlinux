#!/bin/bash
# Dùng ddcutil để chỉnh độ sáng màn hình ngoài, sau đó gọi swayosd để hiện thông báo

STEP=10

if [ "$1" == "up" ]; then
    # Tăng 10%
    ddcutil setvcp 10 + $STEP &
    # Gọi OSD của Sway (nếu máy có màn hình laptop nó cũng sẽ tăng 1 nấc)
    swayosd-client --brightness raise
elif [ "$1" == "down" ]; then
    # Giảm 10%
    ddcutil setvcp 10 - $STEP &
    swayosd-client --brightness lower
fi

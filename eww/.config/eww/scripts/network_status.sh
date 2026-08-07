#!/bin/bash
if grep -q "up" /sys/class/net/e*/operstate 2>/dev/null; then
    echo "󰈀"
elif grep -q "up" /sys/class/net/w*/operstate 2>/dev/null; then
    echo "󰤨"
else
    echo "󰤭"
fi

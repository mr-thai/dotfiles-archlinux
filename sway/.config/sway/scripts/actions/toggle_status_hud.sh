#!/bin/bash

if eww active-windows | grep -E "status_hud" > /dev/null; then
    eww close status_hud
else
    eww open status_hud
    # sleep 4
    # eww close status_hud
fi

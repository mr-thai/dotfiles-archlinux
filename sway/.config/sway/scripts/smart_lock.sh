#!/bin/bash

APPS="firefox electron"

for app in $APPS; do
    pkill -STOP "$app" 2>/dev/null
done

# Run swaylock with -f so it blocks until screen is securely painted,
# then forks to background and returns so systemd can sleep.
swaylock -f -c 11111b

# Fork a background watcher to unfreeze apps after unlock
(
    while pgrep -x swaylock >/dev/null; do
        sleep 1
    done
    
    for app in $APPS; do
        pkill -CONT "$app" 2>/dev/null
    done
) &

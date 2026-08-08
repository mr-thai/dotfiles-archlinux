#!/bin/bash

APPS="firefox electron"

for app in $APPS; do
    pkill -STOP "$app" 2>/dev/null
done

# Run swaylock with -f so it blocks until screen is securely painted,
# then forks to background and returns so systemd can sleep.
dms ipc call lock lock

# Fork a background watcher to unfreeze apps after unlock
(
    while pgrep -x dms >/dev/null && dms ipc call lock isLocked | grep -q 'true'; do
        sleep 1
    done
    
    for app in $APPS; do
        pkill -CONT "$app" 2>/dev/null
    done
) &

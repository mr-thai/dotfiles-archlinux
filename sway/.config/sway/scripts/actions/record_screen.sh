#!/bin/bash
RECORDING_DIR=~/Videos/Recordings
mkdir -p "$RECORDING_DIR"

SLURP_SELECT_ARGS="-b #1e1e2e44 -c #cba6f7ff -s #cba6f722 -w 2"
AUDIO_ARGS="-a default_output"

is_recording() {
    pgrep -f "gpu-screen-recorder" > /dev/null
}

case "$1" in
    display)
        if is_recording; then
            "$0" stop
            exit 0
        fi
        
        MONITORS=$(swaymsg -t get_outputs | jq -r '.[].name')
        MONITOR=$(echo "$MONITORS" | fuzzel --dmenu -a center -l 2 -w 20 -p "Select Monitor: ")
        
        if [ -z "$MONITOR" ]; then
            notify-send -t 2000 "Screen Record" "Cancelled monitor selection."
            exit 0
        fi

        FILE="$RECORDING_DIR/recording_$(date +%Y%m%d_%H%M%S).mp4"
        
        notify-send -t 2000 "Screen Record" "Started recording $MONITOR..."
        gpu-screen-recorder -w "$MONITOR" $AUDIO_ARGS -o "$FILE" &
        eww open record_hud
        ;;

    region)
        if is_recording; then
            "$0" stop
            exit 0
        fi
        
        FILE="$RECORDING_DIR/recording_$(date +%Y%m%d_%H%M%S).mp4"
        GEOMETRY=$(slurp $SLURP_SELECT_ARGS)
        
        if [ -z "$GEOMETRY" ]; then
            notify-send -t 2000 "Screen Record" "Cancelled region recording."
            exit 0
        fi
        
        REGION=$(echo "$GEOMETRY" | sed -E 's/([0-9]+),([0-9]+) ([0-9]+)x([0-9]+)/\3x\4+\1+\2/')
        
        notify-send -t 2000 "Screen Record" "Started recording selected region..."
        gpu-screen-recorder -w "$REGION" $AUDIO_ARGS -o "$FILE" &
        eww open record_hud
        ;;

    stop)
        if is_recording; then
            pkill -SIGINT -f "gpu-screen-recorder"
            eww close record_hud 2>/dev/null
            while is_recording; do
                sleep 0.2
            done
            notify-send -t 3000 "Screen Record" "Stopped recording and saved video!"
        fi
        ;;


    *)
        echo "Usage: $0 {display|region|stop|status}"
        exit 1
        ;;
esac

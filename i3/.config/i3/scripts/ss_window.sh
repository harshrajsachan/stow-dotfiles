#!/bin/bash

DIR="$HOME/Screenshots"
mkdir -p "$DIR"

FILE="$DIR/$(date +'%Y-%m-%d_%H-%M-%S').png"

WIN_ID=$(xdotool getwindowfocus)

# Debug (optional)
echo "Window ID: $WIN_ID" >>/tmp/shot_debug.log

maim -i "$WIN_ID" "$FILE"

if [ -f "$FILE" ]; then
  xclip -selection clipboard -t image/png <"$FILE"
  notify-send "Screenshot Taken" "Saved & copied to clipboard"
else
  notify-send "Screenshot Failed" "File not created"
fi

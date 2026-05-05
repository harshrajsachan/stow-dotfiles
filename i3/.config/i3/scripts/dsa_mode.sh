#!/usr/bin/env bash

STATE_FILE="/tmp/dsa_mode_on"
OUTPUT="eDP-1" # change if needed

if [ -f "$STATE_FILE" ]; then
  # --- TURN OFF ---
  notify-send "DSA Mode" "Deactivate"

  # Reset display
  xrandr --output "$OUTPUT" --gamma 1:1:1

  # Kill ONLY DSA terminal window
  i3-msg '[class="DSA"] kill'

  rm "$STATE_FILE"

else
  # --- TURN ON ---
  notify-send "DSA Mode" "Activate"

  pkill redshift 2>/dev/null

  # Red screen
  xrandr --output "$OUTPUT" --gamma 1:0:0

  # Prevent duplicate windows
  if i3-msg -t get_tree | grep -q '"class":"DSA"'; then
    exit 0
  fi

  # Launch nvim with identifiable class
  kitty --class DSA -e nvim -c "Leet" &

  touch "$STATE_FILE"
fi

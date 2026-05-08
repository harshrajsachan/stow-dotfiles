#!/bin/bash

# Your wallpapers
WALLPAPERS=(
  "$HOME/Pictures/3.png"
  "$HOME/Pictures/1.jpg"
  "$HOME/Pictures/6.jpg"
  "$HOME/Pictures/5.jpg"
  "$HOME/Pictures/4.jpg"
  "$HOME/Pictures/2.png"
  "$HOME/Pictures/9.jpg"
  "$HOME/Pictures/10.jpg"
)

STATE_FILE="$HOME/.cache/wall_index"

# Default index
if [ ! -f "$STATE_FILE" ]; then
  echo 0 >"$STATE_FILE"
fi

INDEX=$(cat "$STATE_FILE")

# Set wallpaper
feh --bg-fill "${WALLPAPERS[$INDEX]}"

# Next index
INDEX=$(((INDEX + 1) % ${#WALLPAPERS[@]}))

echo $INDEX >"$STATE_FILE"

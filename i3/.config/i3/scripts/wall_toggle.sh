#!/bin/bash

# Your wallpapers
WALLPAPERS=(
  "$HOME/Pictures/1.jpg"
  "$HOME/Pictures/29.jpg"
  "$HOME/Pictures/3.png"
  "$HOME/Pictures/10.jpg"
  "$HOME/Pictures/23.png"
  "$HOME/Pictures/20.jpg"
  "$HOME/Pictures/4.jpg"
  "$HOME/Pictures/50.jpg"
  "$HOME/Pictures/51.jpg"
  "$HOME/Pictures/52.jpg"
  "$HOME/Pictures/53.jpg"
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

#!/bin/bash

WALL_DIR="$HOME/Pictures"
STATE="$HOME/.cache/wall_index"
DEFAULT="201.jpg"

mapfile -t WALLPAPERS < <(
  find "$WALL_DIR" -maxdepth 1 -type f \
    \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | sort
)

COUNT=${#WALLPAPERS[@]}
((COUNT == 0)) && exit 1

# Find the index of the default wallpaper
DEFAULT_INDEX=0
for i in "${!WALLPAPERS[@]}"; do
  if [[ "$(basename "${WALLPAPERS[$i]}")" == "$DEFAULT" ]]; then
    DEFAULT_INDEX=$i
    break
  fi
done

# Startup mode
if [[ "$1" == "default" ]]; then
  feh --bg-fill "${WALLPAPERS[$DEFAULT_INDEX]}"
  echo $(((DEFAULT_INDEX + 1) % COUNT)) >"$STATE"
  exit 0
fi

# Cycle mode
if [[ -f "$STATE" ]]; then
  INDEX=$(<"$STATE")
else
  INDEX=$DEFAULT_INDEX
fi

INDEX=$((INDEX % COUNT))

feh --bg-fill "${WALLPAPERS[$INDEX]}"

echo $(((INDEX + 1) % COUNT)) >"$STATE"

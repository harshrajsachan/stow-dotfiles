#!/bin/bash

WALL_DIR="$HOME/Pictures"

# Only images directly inside ~/Pictures
mapfile -t WALLPAPERS < <(
  find "$WALL_DIR" -maxdepth 1 -type f \
    \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | sort
)

COUNT=${#WALLPAPERS[@]}
[[ $COUNT -eq 0 ]] && exit 1

STATE="$HOME/.cache/wall_index"

if [[ -f "$STATE" ]]; then
  INDEX=$(<"$STATE")
else
  INDEX=0
fi

INDEX=$((INDEX % COUNT))

feh --bg-fill "${WALLPAPERS[$INDEX]}"

echo $(((INDEX + 1) % COUNT)) >"$STATE"

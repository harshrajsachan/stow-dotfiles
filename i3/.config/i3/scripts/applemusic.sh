#!/bin/bash

STATE="/tmp/musicapp.state"
HIDDEN="__hidden"

if ! i3-msg '[con_mark="musicapp"] focus' | grep -q '"success":true'; then
  helium-browser --app="https://music.youtube.com" &
  echo "shown" >"$STATE"
  exit
fi

if [ ! -f "$STATE" ]; then
  echo "shown" >"$STATE"
fi

if grep -q "shown" "$STATE"; then
  i3-msg '[con_mark="musicapp"] move container to workspace "__hidden"'
  echo "hidden" >"$STATE"
else
  CURRENT=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused).name')
  i3-msg "[con_mark=\"musicapp\"] move container to workspace \"$CURRENT\""
  i3-msg '[con_mark="musicapp"] focus'
  echo "shown" >"$STATE"
fi

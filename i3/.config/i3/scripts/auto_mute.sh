#!/bin/bash

CARD="0"
CONTROL="Auto-Mute Mode"

CURRENT=$(amixer -c "$CARD" sget "$CONTROL" | grep -oE 'Enabled|Disabled')

if [[ "$CURRENT" == "Enabled" ]]; then
  amixer -c "$CARD" sset "$CONTROL" Disabled >/dev/null
  notify-send "Auto-Mute OFF"
else
  amixer -c "$CARD" sset "$CONTROL" Enabled >/dev/null
  notify-send "Auto-Mute ON"
fi

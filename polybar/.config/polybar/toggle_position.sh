#!/bin/bash

BAR_POS_FILE="/tmp/polybar_position"

if [ -f "$BAR_POS_FILE" ]; then
  rm "$BAR_POS_FILE"
else
  touch "$BAR_POS_FILE"
fi

~/.config/polybar/launch.sh

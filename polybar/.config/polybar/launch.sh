#!/bin/bash

killall -q polybar

BAR_POS_FILE="/tmp/polybar_position"

if [ -f "$BAR_POS_FILE" ]; then
  polybar bottom &
else
  polybar top &
fi

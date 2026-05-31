#!/bin/bash

STATE_FILE="/tmp/i3_outer_gap_state"

# Default state
[ ! -f "$STATE_FILE" ] && echo "8" >"$STATE_FILE"

STATE=$(cat "$STATE_FILE")

if [ "$STATE" = "8" ]; then
  i3-msg "gaps outer current set 1"
  echo "1" >"$STATE_FILE"
else
  i3-msg "gaps outer current set 8"
  echo "8" >"$STATE_FILE"
fi

# Keep inner gaps fixed
i3-msg "gaps inner current set 4"

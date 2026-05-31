#!/bin/bash

STEP=1
MIN=10
MAX=100

WIN=$(xdotool getactivewindow)

STATE_FILE="/tmp/window-opacity-$WIN"

# Default opacity
if [ ! -f "$STATE_FILE" ]; then
  CURRENT=100
else
  CURRENT=$(cat "$STATE_FILE")
fi

case "$1" in
up)
  NEW=$((CURRENT + STEP))
  [ "$NEW" -gt "$MAX" ] && NEW=$MAX
  ;;

down)
  NEW=$((CURRENT - STEP))
  [ "$NEW" -lt "$MIN" ] && NEW=$MIN
  ;;

reset)
  NEW=100
  ;;

*)
  exit 1
  ;;
esac

echo "$NEW" >"$STATE_FILE"

OPAQUE=$((NEW * 4294967295 / 100))

xprop -id "$WIN" \
  -f _NET_WM_WINDOW_OPACITY 32c \
  -set _NET_WM_WINDOW_OPACITY "$OPAQUE" >/dev/null

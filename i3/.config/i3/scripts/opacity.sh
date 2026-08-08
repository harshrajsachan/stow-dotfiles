#!/bin/bash

WIN=$(xdotool getactivewindow)
STATE_FILE="/tmp/window-opacity-$WIN"

OPAQUE=4294967295

# Current mode
MODE="transparent"
[ -f "$STATE_FILE" ] && MODE=$(cat "$STATE_FILE")

if [ "$MODE" = "transparent" ]; then
    # Make window fully opaque
    xprop -id "$WIN" \
        -f _NET_WM_WINDOW_OPACITY 32c \
        -set _NET_WM_WINDOW_OPACITY "$OPAQUE" >/dev/null

    echo "opaque" >"$STATE_FILE"
else
    # Remove property so Picom uses opacity-rule again
    xprop -id "$WIN" -remove _NET_WM_WINDOW_OPACITY >/dev/null

    echo "transparent" >"$STATE_FILE"
fi

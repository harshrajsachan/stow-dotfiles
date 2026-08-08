#!/bin/bash

STEP=2
MIN=10
MAX=100

WIN=$(xdotool getactivewindow)

case "$1" in
up)
    NEW=100
    ;;

down)
    CURRENT=$(xprop -id "$WIN" _NET_WM_WINDOW_OPACITY 2>/dev/null |
        awk '{print $3}')

    if [ -z "$CURRENT" ]; then
        CURRENT=100
    else
        CURRENT=$((CURRENT * 100 / 4294967295))
    fi

    NEW=$((CURRENT - STEP))

    [ "$NEW" -lt "$MIN" ] && NEW=$MIN
    ;;

*)
    exit 1
    ;;
esac

OPACITY=$((NEW * 4294967295 / 100))

xprop -id "$WIN" \
    -f _NET_WM_WINDOW_OPACITY 32c \
    -set _NET_WM_WINDOW_OPACITY "$OPACITY" >/dev/null

#!/bin/bash

if pgrep -x polybar >/dev/null; then
  killall -q polybar

  while pgrep -x polybar >/dev/null; do
    sleep 0.2
  done

else
  polybar main >/dev/null 2>&1 &
fi

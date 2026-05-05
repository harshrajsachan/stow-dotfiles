#!/bin/bash

if pgrep -x i3bar >/dev/null; then
  killall i3bar
else
  i3-msg restart
  sleep 1
  feh --bg-fill ~/Pictures/4.png
fi

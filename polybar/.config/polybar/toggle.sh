#!/usr/bin/env bash

if pgrep -x polybar >/dev/null; then
  killall polybar
else
  ~/.config/polybar/launch.sh
fi

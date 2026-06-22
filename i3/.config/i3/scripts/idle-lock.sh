#!/bin/bash

# Kill old instance if restarted
pkill -x xidlehook

xidlehook \
  --not-when-fullscreen \
  --not-when-audio \
  --timer 300 "$HOME/.config/i3/scripts/lock.sh" ""

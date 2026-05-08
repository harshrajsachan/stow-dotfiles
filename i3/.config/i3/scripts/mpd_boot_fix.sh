#!/bin/bash

# wait for audio/session restore
sleep 0.3

# stop playback instantly
mpc stop >/dev/null 2>&1

# kill restored daemon
pkill -TERM -x mpd >/dev/null 2>&1

# wait until fully dead
while pgrep -x mpd >/dev/null; do
  sleep 0.1
done

# remove saved state
rm -f ~/.config/mpd/state

# start fresh daemon
mpd ~/.config/mpd/mpd.conf

sleep 0.5

# preload playlist silently
mpc clear >/dev/null 2>&1
mpc add Favorites >/dev/null 2>&1
mpc random on >/dev/null 2>&1

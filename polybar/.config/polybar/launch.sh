#!/bin/bash

# Kill existing polybar
killall polybar 2>/dev/null

# Wait until processes are shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar
polybar main &

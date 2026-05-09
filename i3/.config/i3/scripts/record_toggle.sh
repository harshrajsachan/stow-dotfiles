#!/bin/bash

PIDFILE="/tmp/gpu-screen-recorder.pid"

# ------------------------------------------------
# STOP RECORDING
# ------------------------------------------------
if [ -f "$PIDFILE" ]; then
  PID=$(cat "$PIDFILE")

  if ps -p "$PID" >/dev/null 2>&1; then
    kill -INT "$PID"

    FILE=$(cat /tmp/gpu-screen-recorder-file 2>/dev/null)

    rm -f "$PIDFILE"
    rm -f /tmp/gpu-screen-recorder-file

    notify-send "Recording saved" "$FILE"

    exit 0
  else
    rm -f "$PIDFILE"
    rm -f /tmp/gpu-screen-recorder-file
  fi
fi

# ------------------------------------------------
# PREVENT DUPLICATES
# ------------------------------------------------
if pgrep -f "^gpu-screen-recorder" >/dev/null; then
  notify-send "Recorder already running"
  exit 1
fi

# ------------------------------------------------
# START RECORDING
# ------------------------------------------------
mkdir -p "$HOME/Videos"

FILE="$HOME/Videos/recording_$(date +%F_%H-%M-%S).mp4"

echo "$FILE" >/tmp/gpu-screen-recorder-file

gpu-screen-recorder \
  -w screen \
  -f 60 \
  -a default_output \
  -o "$FILE" \
  >/dev/null 2>&1 &

PID=$!

echo "$PID" >"$PIDFILE"

notify-send "Recording started"

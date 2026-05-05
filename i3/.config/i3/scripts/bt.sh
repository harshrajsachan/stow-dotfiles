#!/bin/bash

# === CONFIG ===
DEFAULT_BT="30:CC:8D:99:61:D0"

notify() {
  notify-send "Bluetooth Manager" "$1"
}

usage() {
  echo "Usage:"
  echo "  bt            (connect default device)"
  echo "  bt scan"
  echo "  bt connect [MAC]"
  echo "  bt disconnect [MAC]"
}

# helper → get connected or first known device
get_last_device() {
  MAC=$(bluetoothctl info | awk '/Device/ {print $2; exit}')
  if [ -n "$MAC" ]; then
    echo "$MAC"
  else
    bluetoothctl devices | head -n 1 | awk '{print $2}'
  fi
}

ensure_bt_ready() {
  bluetoothctl power on >/dev/null 2>&1
  bluetoothctl agent on >/dev/null 2>&1
  bluetoothctl default-agent >/dev/null 2>&1
}

# ───────── DEFAULT (no args) ─────────
if [ $# -eq 0 ]; then
  MAC="$DEFAULT_BT"
  notify "Connecting to default device"
  ensure_bt_ready

  if bluetoothctl connect "$MAC"; then
    notify "Connected to $MAC"
  else
    notify "Failed to connect"
  fi
  exit
fi

case "$1" in

scan)
  notify "Scanning for Bluetooth devices (10s)..."

  bluetoothctl power on >/dev/null 2>&1
  bluetoothctl scan on >/dev/null 2>&1
  sleep 10
  bluetoothctl scan off >/dev/null 2>&1

  DEVICES=$(bluetoothctl devices | wc -l)
  notify "Scan complete: $DEVICES device(s) found"

  bluetoothctl devices
  ;;

connect)
  shift

  if [ -z "$1" ]; then
    MAC=$(get_last_device)
    if [ -z "$MAC" ]; then
      notify "No known device found"
      exit 1
    fi
  else
    MAC="$1"
  fi

  notify "Connecting to $MAC"
  ensure_bt_ready

  bluetoothctl pair "$MAC" >/dev/null 2>&1
  bluetoothctl trust "$MAC" >/dev/null 2>&1

  if bluetoothctl connect "$MAC"; then
    notify "Connected to $MAC"
  else
    notify "Connection failed"
  fi
  ;;

disconnect)
  shift

  if [ -z "$1" ]; then
    MAC=$(get_last_device)
    if [ -z "$MAC" ]; then
      notify "No device found"
      exit 1
    fi
  else
    MAC="$1"
  fi

  notify "Disconnecting $MAC"

  if bluetoothctl disconnect "$MAC"; then
    notify "Disconnected"
  else
    notify "Failed to disconnect"
  fi
  ;;

*)
  usage
  ;;
esac

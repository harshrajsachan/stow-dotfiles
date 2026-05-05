#!/bin/bash

IFACE="wlan0"
DEFAULT_WIFI="harsh"

notify() {
  notify-send "WiFi Manager" "$1"
}

usage() {
  echo "Usage:"
  echo "  wifi scan"
  echo "  wifi connect <SSID>"
  echo "  wifi disconnect"
}

# No argument → connect to default
if [ $# -eq 0 ]; then
  notify "Scanning for networks..."
  iwctl station "$IFACE" scan >/dev/null 2>&1
  sleep 1

  notify "Connecting to: $DEFAULT_WIFI"
  if iwctl station "$IFACE" connect "$DEFAULT_WIFI"; then
    notify "Connected to $DEFAULT_WIFI"
  else
    notify "Failed to connect to $DEFAULT_WIFI"
  fi
  exit
fi

case "$1" in
scan)
  notify "Scanning for WiFi networks..."
  iwctl station "$IFACE" scan >/dev/null 2>&1
  sleep 1
  iwctl station "$IFACE" get-networks
  notify "Scan complete"
  ;;

connect)
  shift
  if [ $# -eq 0 ]; then
    usage
    exit 1
  fi

  SSID="$*"
  notify "Connecting to: $SSID"
  if iwctl station "$IFACE" connect "$SSID"; then
    notify "Connected to $SSID"
  else
    notify "Failed to connect to $SSID"
  fi
  ;;

disconnect)
  notify "Disconnecting WiFi..."
  if iwctl station "$IFACE" disconnect; then
    notify "Disconnected"
  else
    notify "Failed to disconnect"
  fi
  ;;

*)
  usage
  ;;
esac

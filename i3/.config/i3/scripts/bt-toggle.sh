#!/bin/bash

# Check Bluetooth power state
status=$(rfkill list bluetooth | grep -i "Soft blocked" | awk '{print $3}')

if [ "$status" = "yes" ]; then
  # Turn ON Bluetooth
  rfkill unblock bluetooth
  systemctl start bluetooth.service
  notify-send "Bluetooth" "Enabled"
else
  # Turn OFF Bluetooth
  systemctl stop bluetooth.service
  rfkill block bluetooth
  notify-send "Bluetooth" "Disabled"
fi

#!/bin/bash

if systemctl is-active --quiet kanata; then
    sudo systemctl stop kanata
    notify-send "Kanata" "OFF"
else
    sudo systemctl start kanata
    notify-send "Kanata" "ON"
fi

#!/bin/bash

current=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused).name')

if [ "$current" = "7" ]; then
  i3-msg workspace "8"
else
  i3-msg workspace "7"
fi

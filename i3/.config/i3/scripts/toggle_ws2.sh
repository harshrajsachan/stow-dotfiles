#!/bin/bash

current=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused).name')

if [ "$current" = "9" ]; then
  i3-msg workspace "10"
else
  i3-msg workspace "9"
fi

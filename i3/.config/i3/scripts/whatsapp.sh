#!/bin/bash

i3-msg '[instance="web.whatsapp.com"] focus'

if [ $? -ne 0 ]; then
  i3-msg 'workspace "whatsapp"'
  helium-browser --app="https://web.whatsapp.com" &
else
  i3-msg 'workspace "whatsapp"'
fi

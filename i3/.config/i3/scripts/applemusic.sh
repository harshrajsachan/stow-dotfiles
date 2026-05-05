#!/bin/bash

i3-msg '[instance="music.apple.com"] focus'

if [ $? -ne 0 ]; then
  i3-msg 'workspace "music"'
  helium-browser --app="https://music.apple.com" &
else
  i3-msg 'workspace "music"'
fi

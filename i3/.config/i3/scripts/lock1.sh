#!/bin/bash

# Don't start another lock if already locked
pgrep -x i3lock && exit 0

# Start i3lock without forking
/usr/bin/i3lock \
  --blur 7x5 \
  --clock \
  --indicator \
  --time-str="%H:%M:%S" \
  --date-str="%A, %d %B" \
  --inside-color=111111aa \
  --ring-color=ffffffcc \
  --line-color=00000000 \
  --separator-color=00000000 \
  --insidever-color=111111aa \
  --insidewrong-color=111111aa \
  --ringver-color=d0d0d0cc \
  --ringwrong-color=707070cc \
  --keyhl-color=ffffffff \
  --bshl-color=c0c0c0ff \
  --time-color=ffffffff \
  --date-color=d0d0d0ff \
  --layout-color=b0b0b0ff \
  --verif-color=ffffffff \
  --wrong-color=909090ff \
  --radius=90 \
  --ring-width=8 \
  --time-font="JetBrainsMono Nerd Font SemiBold" \
  --date-font="JetBrainsMono Nerd Font" \
  --layout-font="JetBrainsMono Nerd Font" \
  --time-size=32 \
  --date-size=14 \
  --layout-size=11 &

sleep 0.5

# Turn monitor off
xset dpms force off

wait

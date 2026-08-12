#!/bin/bash

CONFIG="$HOME/.config/themes/current/i3lock.conf"

# Read colors from the active theme
source "$CONFIG"

exec /usr/bin/i3lock \
    --blur 7x5 \
    --clock \
    --indicator \
    --time-str="%H:%M:%S" \
    --date-str="%A, %d %B" \
    --inside-color="$inside_color" \
    --ring-color="$ring_color" \
    --line-color="$line_color" \
    --separator-color="$separator_color" \
    --insidever-color="$insidever_color" \
    --insidewrong-color="$insidewrong_color" \
    --ringver-color="$ringver_color" \
    --ringwrong-color="$ringwrong_color" \
    --keyhl-color="$keyhl_color" \
    --bshl-color="$bshl_color" \
    --time-color="$time_color" \
    --date-color="$date_color" \
    --layout-color="$layout_color" \
    --verif-color="$verif_color" \
    --wrong-color="$wrong_color" \
    --radius=90 \
    --ring-width=8 \
    --time-font="JetBrainsMono Nerd Font SemiBold" \
    --date-font="JetBrainsMono Nerd Font" \
    --layout-font="JetBrainsMono Nerd Font" \
    --time-size=32 \
    --date-size=14 \
    --layout-size=11

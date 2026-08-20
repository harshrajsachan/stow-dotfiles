#!/bin/bash

WORKSPACE="5"

# Get window count on workspace
COUNT=$(i3-msg -t get_tree | jq "
.. | objects |
select(.type? == \"workspace\" and .name == \"$WORKSPACE\") |
[recurse(.nodes[]?, .floating_nodes[]?) |
select(.window? != null)] |
length
")

# If exactly 4 windows already exist -> switch workspace
if [ "$COUNT" -eq 4 ]; then
  i3-msg "workspace $WORKSPACE"
  exit 0
fi

# If workspace has random windows -> notify and stop
if [ "$COUNT" -gt 0 ]; then
  notify-send "Typing Mode" "Workspace $WORKSPACE is busy"
  exit 1
fi

i3-msg "workspace 5; append_layout ~/.config/i3/typing.json"

helium-browser --app="https://monkeytype.com" &
xdotool search --sync --name "Monkeytype"

helium-browser --app="https://www.typingclub.com" &
xdotool search --sync --name "TypingClub"

helium-browser \
  --disable-gpu \
  --force-device-scale-factor=1 \
  --app="https://keybr.com" &

xdotool search --sync --name "Practice"

i3-msg '[title="^Practice$"] resize grow width 1 px'
i3-msg '[title="^Practice$"] resize shrink width 1 px'
i3-msg '[title="^Practice$"] resize grow height 1 px'
i3-msg '[title="^Practice$"] resize shrink height 1 px'

alacritty -e toofan &

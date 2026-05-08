#!/bin/bash

CONFIG="$HOME/.config/mpd/mpd.conf"
STATE_FILE="$HOME/.config/mpd/current_folder_index"
MUSIC_DIR="$HOME/Music"

notify() {
  notify-send "MPD" "$1"
}

is_mpd_running() {
  pgrep -x mpd >/dev/null
}

start_mpd() {

  # fully kill old restored session
  pkill -9 -x mpd >/dev/null 2>&1

  sleep 1

  # remove saved playback state
  rm -f "$HOME/.config/mpd/state"

  # start fresh daemon
  mpd "$CONFIG"

  sleep 1

  # ensure silent startup
  mpc stop >/dev/null 2>&1

  # preload favorites
  mpc clear >/dev/null 2>&1
  mpc add "Favorites" >/dev/null 2>&1
  mpc random on >/dev/null 2>&1
}

# 🔒 Block everything except "stop" if MPD not running
if ! is_mpd_running && [[ "$1" != "stop" ]]; then
  exit
fi

CMD="$1"
shift

case "$CMD" in

# ───────── BASIC CONTROLS ─────────

play)
  mpc play
  ;;

pause)
  mpc pause
  ;;

toggle)

  STATUS=$(mpc status | grep -o "\[.*\]" | tr -d '[]')

  if [ "$STATUS" = "playing" ]; then
    mpc pause
  else
    mpc play
  fi
  ;;

next)
  mpc next && notify "Next song"
  ;;

prev)
  mpc prev && notify "Previous song"
  ;;

# ───────── POWER BUTTON ─────────

stop)

  if is_mpd_running; then

    # stop playback
    mpc stop >/dev/null 2>&1

    sleep 0.5

    # kill daemon
    pkill -TERM -x mpd

    # wait until fully closed
    while pgrep -x mpd >/dev/null; do
      sleep 0.1
    done

    # remove playback restore state
    rm -f "$HOME/.config/mpd/state"

    notify "MPD stopped"

  else

    start_mpd

    notify "MPD Loaded"

  fi
  ;;

# ───────── DATABASE ─────────

update)
  mpc update && notify "Database updated"
  ;;

# ───────── FAVORITES ─────────

fav)

  FILE=$(mpc --format %file% current)
  SRC="$MUSIC_DIR/$FILE"

  mkdir -p "$MUSIC_DIR/Favorites"

  BASENAME=$(basename "$FILE")

  if [ -e "$MUSIC_DIR/Favorites/$BASENAME" ]; then
    notify "Already in Favorites"
    exit
  fi

  cp "$SRC" "$MUSIC_DIR/Favorites/"

  notify "Added to Favorites"
  ;;

# ───────── TRASH ─────────

trash)

  FILE=$(mpc --format %file% current)

  gio trash "$MUSIC_DIR/$FILE"

  mpc next
  mpc update

  notify "Moved to Trash"
  ;;

# ───────── FOLDER CYCLING ─────────

cycle | cycle_next)

  mapfile -t FOLDERS < <(
    find "$MUSIC_DIR" \
      -mindepth 1 \
      -maxdepth 1 \
      -type d | sort
  )

  TOTAL=${#FOLDERS[@]}

  [ "$TOTAL" -eq 0 ] && exit

  INDEX=0

  [ -f "$STATE_FILE" ] && INDEX=$(cat "$STATE_FILE")

  INDEX=$(((INDEX + 1) % TOTAL))

  echo "$INDEX" >"$STATE_FILE"

  FOLDER=$(basename "${FOLDERS[$INDEX]}")

  mpc clear
  mpc add "$FOLDER"
  mpc random on
  mpc play

  notify "Playing: $FOLDER"
  ;;

cycle_prev)

  mapfile -t FOLDERS < <(
    find "$MUSIC_DIR" \
      -mindepth 1 \
      -maxdepth 1 \
      -type d | sort
  )

  TOTAL=${#FOLDERS[@]}

  [ "$TOTAL" -eq 0 ] && exit

  INDEX=0

  [ -f "$STATE_FILE" ] && INDEX=$(cat "$STATE_FILE")

  INDEX=$(((INDEX - 1 + TOTAL) % TOTAL))

  echo "$INDEX" >"$STATE_FILE"

  FOLDER=$(basename "${FOLDERS[$INDEX]}")

  mpc clear
  mpc add "$FOLDER"
  mpc random on
  mpc play

  notify "Playing: $FOLDER"
  ;;

# ───────── SEEK CONTROLS ─────────

forward)
  mpc seek +10 >/dev/null
  ;;

backward)
  mpc seek -10 >/dev/null
  ;;

# ───────── REPEAT ONE TOGGLE ─────────

repeat_one)

  STATUS=$(mpc status)

  if echo "$STATUS" | grep -q "repeat: on" &&
    echo "$STATUS" | grep -q "single: on"; then

    mpc repeat off
    mpc single off

    notify "Repeat One: OFF"

  else

    mpc repeat on
    mpc single on

    notify "Repeat One: ON"
  fi
  ;;

*)
  exit
  ;;

esac

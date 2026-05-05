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
  mpd "$CONFIG"
  sleep 0.5
}

# 🔒 Block everything except "stop" and "fzf" if MPD not running
if ! is_mpd_running && [[ "$1" != "stop" && "$1" != "fzf" ]]; then
  exit
fi

CMD="$1"
shift

case "$CMD" in
# ───────── BASIC CONTROLS ─────────
play)
  mpc play && notify "Play"
  ;;

pause)
  mpc pause && notify "Paused"
  ;;

toggle)
  STATUS=$(mpc status | grep -o "\[.*\]" | tr -d '[]')
  if [ "$STATUS" = "playing" ]; then
    mpc pause && notify "Paused"
  else
    mpc play && notify "Playing"
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
    mpc stop
    pkill -x mpd
    notify "MPD stopped"
  else
    start_mpd
    mpc clear
    mpc add "Favorites"
    mpc random on
    mpc play
    notify "MPD started"
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
  mapfile -t FOLDERS < <(find "$MUSIC_DIR" -mindepth 1 -maxdepth 1 -type d | sort)
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
  mapfile -t FOLDERS < <(find "$MUSIC_DIR" -mindepth 1 -maxdepth 1 -type d | sort)
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
  mpc seek +10 >/dev/null && notify "⏩ +10s"
  ;;

backward)
  mpc seek -10 >/dev/null && notify "⏪ -10s"
  ;;
# ───────── REPEAT ONE TOGGLE ─────────
repeat_one)
  STATUS=$(mpc status)

  if echo "$STATUS" | grep -q "repeat: on" && echo "$STATUS" | grep -q "single: on"; then
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

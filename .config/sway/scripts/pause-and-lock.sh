#!/bin/sh -e
# required-arch-package :: playerctl
# required-arch-package :: swaylock

lock_cmd="swaylock -Fei $1"
if [ "$(playerctl -p spotify status 2>/dev/null)" = "Playing" ]; then
  playerctl -p spotify pause
  eval "$lock_cmd"
  playerctl -p spotify play
else
  eval "$lock_cmd -f"
fi

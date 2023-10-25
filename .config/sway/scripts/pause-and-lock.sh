#!/bin/sh -e
# required-arch-package :: playerctl
# required-arch-package :: swaylock

if ! pgrep swaylock; then
  lock_cmd="swaylock -Fei /usr/share/wallpapers/wallpaper.jpg"
  if [ "$(playerctl -p spotify status 2>/dev/null)" = "Playing" ]; then
    playerctl -p spotify pause
    eval "$lock_cmd"
    playerctl -p spotify play
  else
    eval "$lock_cmd -f"
  fi
fi

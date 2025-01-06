#!/bin/sh -e
# required-arch-package :: playerctl
# required-arch-package :: swaylock

pkill swaynag || true
if ! pgrep swaylock; then
  lock_cmd="swaylock -Fei /usr/share/wallpapers/wallpaper.jpg"
  now_playing=''
  for item in $(playerctl -a --format "{{playerName}},{{status}}" --ignore-player firefox status); do
    if [ "$(echo "$item" | awk -F',' '{print $2}')" = "Playing" ]; then
      player=$(echo "$item" | awk -F',' '{print $1}')
      playerctl -p "$player" pause
      now_playing="$now_playing $player"
    fi
  done
  if [ -n "$now_playing" ]; then
    eval "$lock_cmd"
    for player in $now_playing; do
      playerctl -p "$player" play
    done
  else
    eval "$lock_cmd -f"
  fi
fi

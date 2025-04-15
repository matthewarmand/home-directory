#!/bin/sh -e
# required-arch-package :: playerctl
# required-arch-package :: swaylock

pkill swaynag || true
if ! pgrep swaylock; then
  now_playing=''
  for item in $(playerctl -a --format "{{playerName}},{{status}}" --ignore-player firefox status); do
    if [ "$(echo "$item" | awk -F',' '{print $2}')" = "Playing" ]; then
      player=$(echo "$item" | awk -F',' '{print $1}')
      playerctl -p "$player" pause
      now_playing="$now_playing $player"
    fi
  done
  swaylock -Fei /usr/share/wallpapers/wallpaper.jpg
  if [ -n "$now_playing" ]; then
    for player in $now_playing; do
      playerctl -p "$player" play
    done
  fi
fi

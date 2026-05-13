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
  cmd='swaylock -Fei /usr/share/wallpapers/wallpaper.png'
  if [ -f "$HOME/.config/swaylock/config-$(uname -n)" ]; then
    cmd="$cmd --config ~/.config/swaylock/config-$(uname -n)"
  fi
  eval "$cmd"
  if [ -n "$now_playing" ]; then
    for player in $now_playing; do
      playerctl -p "$player" play
    done
  fi
fi

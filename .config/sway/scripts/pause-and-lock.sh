#!/bin/sh -e

if [ "$(playerctl -p spotify status 2>/dev/null)" = "Playing" ]; then
  paused_player="true"
  playerctl -p spotify pause
fi
swaylock -Fei "$1"
if [ "$paused_player" = "true" ]; then
  playerctl -p spotify play
fi

#!/bin/sh -e
# This will lock your screen after 5 minutes of inactivity, and put the
# system to sleep after 2 hours of inactivity. It will also lock your
# screen before your computer goes to sleep. It will also give a warning
# 5 seconds before locking.
# required-arch-package :: swayidle
# required-arch-package :: yad

if ! pgrep swayidle; then
  lock_command="source ~/.config/sway/scripts/pause-and-lock.sh"
  swayidle -w \
    timeout 295 "yad --timeout 5 --timeout-indicator top --text 'Machine will idle-lock in 5 seconds' --title 'Lock Warning'" \
    timeout 300 "$lock_command" \
    timeout 7200 "systemctl suspend" \
    before-sleep "$lock_command" &
else
  echo "swayidle is already running"
  exit 1
fi

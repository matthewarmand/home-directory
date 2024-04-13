#!/bin/sh

if [ -n "$(pgrep swayidle)" ]; then
  icon="toggle_on"
else
  icon="toggle_off"
fi
echo "{\"text\": \"Idle-Lock\", \"icon\": \"$icon\"}"

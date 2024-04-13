#!/bin/sh

if pgrep swayidle; then
  icon="toggle_on"
else
  icon="toggle_off"
fi
echo "{\"text\": \"Idle-Lock\", \"icon\": \"$icon\"}"

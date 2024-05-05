#!/bin/sh

if pgrep swayidle >/dev/null; then
  icon="toggle_on"
else
  icon="toggle_off"
fi
echo """
  {
    \"text\": \"Idle-Lock\",
    \"icon\": \"$icon\"
  }
"""

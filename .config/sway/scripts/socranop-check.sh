#!/bin/sh

if socranop-ctl -l 1>/dev/null 2>/dev/null; then
  state="Good"
else
  state="Critical"
fi

channel_lines="$(socranop-ctl -l --no-dbus | grep capture_ | sed 's/capture.*\ <- //; s/\[[0-9]\]//' | paste -sd ',')"
line1="$(echo "$channel_lines" | cut -d',' -f1 | awk '{$1=$1};1')"
line2="$(echo "$channel_lines" | cut -d',' -f2 | awk '{$1=$1};1')"

echo """
  {
    \"text\": \"$line1,$(echo "$line2" | tail -c 2)\",
    \"state\": \"$state\",
    \"icon\": \"icon\"
  }
"""

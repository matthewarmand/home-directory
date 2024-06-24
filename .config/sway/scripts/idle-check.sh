#!/bin/sh

if pgrep swayidle >/dev/null; then
  icon="lock"
else
  icon="lock-open"
fi
echo "{\"icon\": \"$icon\"}"

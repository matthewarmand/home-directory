#!/bin/sh

socranop-ctl -s "$((($(socranop-ctl -l --no-dbus | grep capture_ | grep -oP '\[\K[^\]]+') + 1) % 4))"
pkill -SIGRTMIN+5 i3status-rs

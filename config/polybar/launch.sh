#!/usr/bin/bash

killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar -c ~/.config/polybar/config.ini main &
polybar -c ~/.config/polybar/config.ini main2 &

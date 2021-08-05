#!/usr/bin/env sh

killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar -r -c ~/.config/polybar/config.ini main &
polybar -r -c ~/.config/polybar/config.ini main2 &
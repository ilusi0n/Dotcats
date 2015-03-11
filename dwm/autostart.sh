#!/bin/bash
feh --bg-scale /mnt/Data/Wallpapers/v3/221406.jpg &
ibus-daemon -x -d -s &
#uppr right corner, desactivate, left, activate
xautolock -time 5 -locker 'i3lock -c 111111' -corners 0-+0  -cornerdelay 4 -cornerredelay 4 &
$HOME/.scripts/touchpad_toggle &
/usr/bin/start-pulseaudio-x11 &
thunderbird &
/usr/lib/lxpolkit/lxpolkit &
$HOME/.scripts/drop_start &
xpad &
pcmanfm -d

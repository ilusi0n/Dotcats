#!/bin/bash
feh --bg-scale /mnt/Data/Wallpapers/v3/wallpaper-114539.jpg &
ibus-daemon -x -d -s &
#uppr right corner, desactivate, left, activate
xautolock -time 5 -locker "$HOME/.scripts/lock" -corners 0-+0  -cornerdelay 4 -cornerredelay 4 &
"$HOME/.scripts/touchpad_toggle" &
tint2 -c "$HOME/.dotcats/spectrwm/tint2config" &
thunderbird &
/usr/lib/lxpolkit/lxpolkit &
"$HOME/.scripts/drop_start" &
compton &
redshift-gtk &
pcmanfm -d
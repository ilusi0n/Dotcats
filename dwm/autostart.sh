#!/bin/bash
feh --bg-scale /mnt/Data/Wallpapers/v2/wallpaper-82310.jpg &
sleep 3 && ibus-daemon -x -d -s &
#sleep 3 && xscreensaver -no-splash &
#uppr right corner, desactivate, left, activate
xautolock -time 5 -locker 'i3lock -c 111111' -corners 0-+0  -cornerdelay 4 -cornerredelay 4 &
#sleep 3 && wicd-client --tray &
sleep 3 && connman-ui-gtk &
#sleep 3 && sudo $HOME/.scripts/powersaving AC &
thunar --daemon &
$HOME/.scripts/touchpad_toggle &
/usr/bin/start-pulseaudio-x11 &


#sleep 3 && sudo /home/ilusi0n/.scripts/renice &

$HOME/.scripts/drop_start

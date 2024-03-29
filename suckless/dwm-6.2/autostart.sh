#!/bin/bash
{
sleep 2;
xrandr --setprovideroutputsource modesetting NVIDIA-0;
xrandr --output eDP-1-1 --auto --gamma 0.8:0.8:0.8 --brightness 0.8;
xrandr --output HDMI-0 --primary --auto --left-of eDP-1-1;
nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }";
} &
light -S 40 &
setxkbmap -layout pt &
wmname LG3D &
feh --bg-fill --randomize /mnt/Data/Wallpapers/*
#xautolock -time 8 -locker "$HOME/.scripts/lock" -corners 0-+0  -cornerdelay 4 -cornerredelay 4 &
#xidlehook --not-when-fullscreen --not-when-audio --timer 300 ''"$HOME"/.scripts/lock'' '' &
xsettingsd &
#slstatus &
#lxqt-policykit-agent &
#dunst &
/usr/lib/lxpolkit/lxpolkit &
sct 4500 #sct 8000

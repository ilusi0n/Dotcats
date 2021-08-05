#!/bin/bash


{
sleep 5; 
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --output eDP-1-1 --auto --gamma 0.8:0.8:0.8 --brightness 0.8 --output HDMI-0 --primary --auto --left-of eDP-1-1
nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"
} &



ssh-agent &
ssh-add ~/.ssh/id_rsa &
light -S 60 &
setxkbmap -layout pt &
lxqt-policykit-agent &
#redshift &
wmname LG3D &
feh --bg-scale /mnt/Data/Wallpapers/moon.jpg
#xautolock -time 5 -locker "$HOME/.scripts/lock" -corners 0-+0  -cornerdelay 4 -cornerredelay 4
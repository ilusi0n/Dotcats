#!/bin/bash

ssh-agent &
ssh-add ~/.ssh/id_rsa &
light -S 60 &
setxkbmap -layout pt &
lxqt-policykit-agent &
#redshift &
wmname LG3D &
#picom &

#prime, no xorh config
#xrandr --auto &
#xrandr --output eDP1 --auto --gamma 0.8:0.8:0.8 --brightness 0.8 &
#xrandr --output HDMI-1-0 --primary --auto --left-of eDP1

#nvidia modeset
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
xrandr --output eDP-1-1 --auto --gamma 0.8:0.8:0.8 --brightness 0.8
xrandr --output HDMI-0 --primary --auto --left-of eDP-1-1
#nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"
xrandr --output eDP-1-1 --set "PRIME Synchronization" 1
#!/bin/bash
# {
# sleep 2;
# xrandr --setprovideroutputsource modesetting NVIDIA-0;
# xrandr --output eDP-1-1 --auto --gamma 0.8:0.8:0.8 --brightness 0.8;
# xrandr --output HDMI-0 --primary --auto --left-of eDP-1-1;
# nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }";
# } &

{
sleep 2;
xrandr --setprovideroutputsource modesetting NVIDIA-0;
xrandr --output eDP-1-1 --auto --gamma 0.8:0.8:0.8 --brightness 0.8;
xrandr --output DP-0 --auto --left-of eDP-1-1;
xrandr --output HDMI-0 --primary --auto --left-of DP-0;
#nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }";
} &

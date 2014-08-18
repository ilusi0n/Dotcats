#!/bin/sh

$HOME/.dotcats/dwm/autostart.sh &
while true; do 
    $HOME/.dotcats/dwm/dwm_status.sh
    sleep 2s
done

#!/bin/sh

batt=/sys/class/power_supply/BAT1/

current=$(<"${batt}"/charge_now)
full=$(<"${batt}"/charge_full)
state=$(<"${batt}"/status)

charge=$(( current * 100 / $full )) 

case "${state}" in
    Full) batstat="[=]" ;; # should be Full
    Charging) batstat="[+]" ;;
    Discharging) batstat="[-]" ;;
esac

printf '%s\n' "${batstat} ${charge}%"



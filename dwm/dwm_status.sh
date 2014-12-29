#!/bin/bash
# Credits:
# ########
#
#
# ## Status bar options:
# http://0mark.unserver.de/projects/dwm-sprinkles/tfm
#
# ## Battery, monitor brightness cripts & lots of details:
# Jason Ryan (http://jasonwryan.com/)
#
# w0ng for providing examples that let
# resolve a few issues
#
# A few kind guys whose names I cannot recall,
# but whose work came of great help.
#
# adapted from bohoomil
#

#C01="\x01" # norm [white]
#C02="\x02" # sel  [blue]
#C03="\x03" # urg  [red]
#C04="\x04" # mid  [white]
#C05="\x05" # orange
#C06="\x06" # light green
#C07="\x07" # purple
#C08="\x08" # light blue
#C09="\x09" # azure
#C10="\x0A" # light orange

colors=('\x01' '\x02' '\x03' '\x04' '\x05' '\x06' '\x07' '\x08' '\x09' '\x0A'
'\x0B')

: '
C06="\x06" # black0
C07="\x07" # black8
C08="\x08" # red1
C09="\x09" # red9
C10="\x0A" # green2
C11="\x0B" # green10
C12="\x0C" # yellow3
C13="\x0D" # yellow11
C14="\x0E" # blue4
C15="\x0F" # blue12
C16="\x10" # magenta5
C17="\x11" # magenta13
C18="\x12" # cyan6
C19="\x13" # cyan14
C20="\x14" # white7
C21="\x15" # white15
C22="\x16" # dwm norm bg
C23="\x17" # xorg bg
C24="\x18" # norm grey
C25="\x19" # dwm selbg

'

sep1="${colors[3]} > "

cputmp(){
    hddt="$(sensors | awk '/Physical/ {print substr($4,2,2);}')"
    echo -e "${colors[4]}T: ${hddt}"
}

bat(){
    batst="$($HOME/.scripts/bat.sh)"
    batt='/sys/class/power_supply/BAT1/'
    state=$(<"${batt}"/status)
    if [[ $state == 'Discharging' ]] || [[ $state == 'Charging' ]]; then
        echo -e "${sep1}${colors[4]}Bat ${batst}"
    fi
}


cpu(){
    read cpu a b c previdle rest < /proc/stat
    prevtotal=$((a+b+c+previdle))
    sleep 0.5
    read cpu a b c idle rest < /proc/stat
    total=$((a+b+c+idle))
    cpu="$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))"
    echo -e "${sep1}${colors[6]}CPU ${cpu}%"
}

vol(){
    level="$(ponymix -d 0 get-volume)"
    echo -e "${sep1}${colors[7]}Vol: ${level}%"
}
mpd(){
    track="$(mpc current)"
    artist="${track%%- *}"
    title="${track#*- }"
    [[ -n $artist ]] && echo -e "${colors[6]} ${artist}- ${title}${colors[3]}>"
}

dte(){
    dat="$(date "+%a %b %d, %R")"
    echo -e "${sep1}${colors[5]}${dat}"
}

weather(){
    weather="$(cat /tmp/weather)"
    [[ -n $weather ]] && echo -e "${colors[10]}${weather}${colors[3]}>"
}

hddwarn(){
    warn="$(df -h | awk '/sda6/ { gsub("%","",$5) ; print $5 }')"
    [[ $warn -gt 95 ]] && echo -e "${sep1}${colors[2]}BAZINGA"
}

# pipe it
xsetroot -name "$(hddwarn)$(mpd)$(weather)$(cputmp)$(cpu)$(bat)$(vol)$(dte)"

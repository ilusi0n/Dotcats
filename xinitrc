#!/bin/sh
#
# ~/.xinitrc

#------EXPORTS---#
export GDK_USE_XFT=1
export QT_XFT=true
export GTK2_RC_FILES="/etc/gtk-2.0/gtkrc:$HOME/.gtkrc-2.0"
export QT_STYLE_OVERRIDE=gtk
export EDITOR=vim
export PULSE_LATENCY_MSEC=60
export DE="gnome"
export XDG_CONFIG_HOME="$HOME/.config"
export QT_PLUGIN_PATH=$HOME/.kde4/lib/kde4/plugins/:/usr/lib/kde4/plugins/
export MOZ_USE_OMTC=1


if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?* ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# source Xresources
xrdb -merge "$HOME/.Xresources" > /dev/null 2>&1

#colors for terminal and stuff
eval "$(dircolors ~/.dircolors)"

# local bin
PATH=~/bin:$PATH
export PATH

#java
wmname LG3D &

#persistent cache
ln -s "$HOME/.cacheme/spotify" "$HOME/.cache/spotify" > /dev/null 2>&1
ln -s "$HOME/.cacheme/gmpc" "$HOME/.cache/gmpc" > /dev/null 2>&1
ln -s "$HOME/.cacheme/wine" "$HOME/.cache/wine" > /dev/null 2>&1

#settings for gtk3
~/bin/gtk3settings &

WM="dwm"

case "$WM" in
    dwm)
        "$HOME/.dotcats/dwm/dwm_start.sh" &
        exec dwm
        ;;
    wmfs)
        "$HOME/.config/wmfs/autostart" &
        exec wmfs
        ;;
    awesome)
        exec awesome
        ;;
    spectrwm)
       "$HOME/.dotcats/spectrwm/autostart.sh" &
       exec spectrwm
       ;;
esac
